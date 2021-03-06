#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include "config.h"
#include "mp_msg.h"
#include "sys/stat.h"
#include "sys/fcntl.h"
#include "sys/ioctl.h"
#include "sys/mman.h"
#include "fcntl.h"
#include <linux/fb.h>
#include <unistd.h>

#include "libavcodec/avcodec.h"
#include "libmpcodecs/img_format.h"
#include "stream/stream.h"
#include "libmpdemux/demuxer.h"
#include "libmpdemux/stheader.h"

#include "libmpcodecs/img_format.h"
#include "libmpcodecs/mp_image.h"
#include "libmpcodecs/vf.h"
#include "libswscale/swscale.h"
#include "libswscale/swscale_internal.h"
#include "libmpcodecs/vf_scale.h"

#define JZ4750_IPU
//#define NEED_COPY_IMGBUF
#ifdef JZ4750_IPU
#include "jz4750_ipu.h"
#undef printf
#define USE_IMEM_ALLOC 

#define LCD_BPP 32
#define FB_LCD_WIDTH 480 //lcd_get_width()
#define FB_LCD_HEIGHT 272 //lcd_get_height()
#define LCD_BPP_BYTE (LCD_BPP / 8)

typedef struct {
    AVCodecContext *avctx;
    AVFrame *pic;
    enum PixelFormat pix_fmt;
    float last_aspect;
    int do_slices;
    int do_dr1;
    int vo_inited;
    int best_csp;
    int b_age;
    int ip_age[2];
    int qp_stat[32];
    double qp_sum;
    double inv_qp_sum;
    int ip_count;
    int b_count;
} vd_ffmpeg_ctx;

struct vf_priv_s {
    int w,h;
    int v_chr_drop;
    double param[2];
    unsigned int fmt;
    struct SwsContext *ctx;
    struct SwsContext *ctx2; //for interlaced slices only
    unsigned char* palette;
    int interlaced;
    int noup;
    int accurate_rnd;
    int query_format_cache[64];
};

#define PAGE_SIZE (4096)
#define MEM_ALLOC_DEV_NUM 1

struct mem_dev {
  unsigned int vaddr;
  unsigned int paddr;
  unsigned int totalsize;
  unsigned int usedsize;
} memdev[MEM_ALLOC_DEV_NUM]; 

#ifdef USE_IMEM_ALLOC 
char *memfname[]={"/proc/jz/imem", 
                  "/proc/jz/imem",
                  "/proc/jz/imem", 
                  "/proc/jz/imem"};
#endif

#define FBIOPRINT_REG		0x468c /* print lcd registers(debug) */

int fbfd;
/* 0 : toggle ;  1 : no toggle */
static int put_image_cnt = 0;
static int toggle_flag = 0;
unsigned int dcache[4096];
static int mem_init = 0, memdev_count = 0;
int mmapfd = 0;
static int ipu_inited = 0, ipu_size_cfg = 0, get_fbinfo_already = 0;
static int ipu_rtable_init = 0, ipu_rtable_len;
int  ipufd, ipu_maped = 0, ipu_image_completed = 0;
volatile unsigned char *ipu_vbase=NULL, *img_ptr=NULL;
volatile unsigned char *frame_buffer=NULL;
unsigned int fb_w, fb_h, phy_fb, fbmemlen, fb_line_len;
unsigned int rsize_w = 0, rsize_h = 0;
unsigned int out_width, out_height;
static unsigned int out_x,out_y,out_w,out_h,frame_offset = 0;
static void fullscreen(int w,int h);


#define IPU_LUT_LEN 20
struct Ration2m ipu_ratio_table[(IPU_LUT_LEN) * (IPU_LUT_LEN)];
rsz_lut h_lut[IPU_LUT_LEN];
rsz_lut v_lut[IPU_LUT_LEN];


#define MP_IMAGE_TYOE_SIZE_FINISH 0
#define MP_IMAGE_TYPE_CUSTORM     1
#define MP_IMAGE_TYPE_INITSIZE    2
#define MP_IMAGE_TYPE_EQSIZE      3
#define MP_IMAGE_TYPE_FULLSCREEN  4



void get_fbaddr_info ()
{
  
  struct fb_var_screeninfo fbvar;
  struct fb_fix_screeninfo fbfix;

  if ((fbfd = open("/dev/fb0", O_RDWR)) == -1) {
       printf("++ ERR: can't open /dev/fb0 ++\n");
       exit(1);
  }

  ioctl(fbfd, FBIOGET_VSCREENINFO, &fbvar);
  ioctl(fbfd, FBIOGET_FSCREENINFO, &fbfix);

  fb_w = fbvar.xres;
  fb_h = fbvar.yres;

  phy_fb= fbfix.smem_start;
  fbmemlen = fbfix.smem_len;
  fb_line_len=  fbfix.line_length;

  if ((frame_buffer = (uint8_t *) mmap(0, fbmemlen, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0)) == (uint8_t *) -1) 
  {
    printf ("++ jz4740_soc.c: Can't mmap frame buffer ++\n");
    exit (1);
  }

  printf ("++ jz47 fb_w=%d, fb_h=%d, phy_fb=0x%x, fbmemlen=%d, fb_line_len=%d\n",
          fb_w, fb_h, phy_fb, fbmemlen, fb_line_len);
}

unsigned int get_phy_addr (unsigned int vaddr)
{
  int i;
  for (i = 0; i < memdev_count; i++)
  {
    if (vaddr >= memdev[i].vaddr && vaddr < memdev[i].vaddr + memdev[i].totalsize)
      return memdev[i].paddr + (vaddr -  memdev[i].vaddr);
  }
  return 0;
}

void jz4740_free_devmem ()
{
  int power = 255, i;
  unsigned char cmdbuf[100];

  for (i = 0; i < memdev_count; i++)
  {
    if (memdev[i].vaddr) {
	 munmap((void *)memdev[i].vaddr,memdev[i].totalsize);
	 memset(&memdev[i],0,sizeof(struct mem_dev));
	}	
   } 
  
  mem_init = 0;
  memdev_count = 0;

#ifdef USE_IMEM_ALLOC 
  sprintf (cmdbuf, "echo FF > %s", memfname[0]);
  system (cmdbuf);
#endif
}

void *jz4740_alloc_frame (int align, int size)
{
	int power, pages = 1, fd, i;
	int cur_pid = 0;
	unsigned int paddr, vaddr, data;
	unsigned char cmdbuf[100];

	/* Free all proc memory. */
	if (mem_init == 0) {
#ifdef USE_IMEM_ALLOC 
		sprintf (cmdbuf, "echo FF > %s", memfname[0]);
		//echo FF > /proc/jz/imem
		system (cmdbuf);
#endif
		mem_init = 1;
	}
	/* open /dev/mem for mmap the memory. */
	if (mmapfd == 0)
	 	mmapfd = open ("/dev/mem", O_RDWR);
	if (mmapfd <= 0) {
		printf("++ Jz47 alloc frame failed: can not mmap the memory ++\n");
		exit (1);
	}

	for (i = 0; i < memdev_count; i++) {
		int alloc_size, used_size, total_size;
		used_size = memdev[i].usedsize;
		total_size = memdev[i].totalsize;
		alloc_size = total_size - used_size;
		if (alloc_size >= size) {
			/* align to 16 boundary.  */
			alloc_size = (size + 15) & ~(15);
			memdev[i].usedsize = used_size + alloc_size;
			vaddr = memdev[i].vaddr + used_size;
			//printf ("jz mem alloc [%d]: vaddr = 0x%x, paddr = 0x%x size = 0x%x , total = 0x%x\n",i, vaddr, memdev[i].paddr + used_size, size, memdev[i].usedsize);
#if 0
			if (toggle_flag == 0) {
			//if (memdev[i].usedsize >= 0x152e80) {
				toggle_jz47_tlb();
			}
#endif
			return (void *)vaddr;
		}
	}

	if (memdev_count <  MEM_ALLOC_DEV_NUM) {
		/* request the new memory space */
		power = 10;    /* request mem size of 2 ^ 10 pages, 4M space */
		pages = 1 << power; /* total page numbers */
		// request mem
		sprintf (cmdbuf, "echo %x > %s", power, memfname[memdev_count]);
		system (cmdbuf);
		// get paddr
		fd = open(memfname[memdev_count], O_RDWR);
		if (fd >= 0)
			read (fd, &paddr, 4); 
		close(fd);
		/* failed, so free the memory. */
		if (paddr == 0) { 
			printf("++ Jz47 can not get address of reserved 4M memory\n");
			exit (1);
		} else {
			/* mmap the memory and record vadd and paddr. */
			vaddr = (unsigned int)mmap ((void *)0x2b800000,
						    pages * PAGE_SIZE * 2,
						    (PROT_READ|PROT_WRITE),
						    MAP_SHARED, 
						    mmapfd, 
						    paddr);
			
			memdev[memdev_count].vaddr = vaddr;
			memdev[memdev_count].paddr = paddr;
			memdev[memdev_count].totalsize = (pages * PAGE_SIZE);
			memdev[memdev_count].usedsize = 0;
			memdev_count++;
			printf ("jz Dev alloc 2: vaddr = 0x%x, paddr = 0x%x size = 0x%x ++\n", vaddr, paddr, (pages * PAGE_SIZE));
		}
	}//if (memdev_count <  MEM_ALLOC_DEV_NUM)
	
	for (i = 0; i < memdev_count; i++) {
		int alloc_size, used_size, total_size;
		used_size = memdev[i].usedsize;
		total_size = memdev[i].totalsize;
		alloc_size = total_size - used_size;
		//printf("1 [ i=%d uesd=%d total=%d alloc_size=%d size=%d ] \n",i,memdev[i].usedsize,memdev[i].totalsize,alloc_size,size);
		if (alloc_size >= size) {
			/* align to 16 boundary.  */
			alloc_size = (size + 15) & ~(15);
			memdev[i].usedsize = used_size + alloc_size;
			vaddr = memdev[i].vaddr + used_size;
			//printf ("jz mem alloc [%d]: vaddr = 0x%x, paddr = 0x%x size = 0x%x\n", i, vaddr, memdev[i].paddr + used_size, size);
			return (void *)vaddr;
		}
	}
	printf ("++ Jz47 alloc: memory allocated is failed (size = %d) ++\n", size);
	//exit (1);
}

/*----------------------------------------------------------------------------------*/

char *ipu_regs_name[] = {
    "REG_CTRL",         /* 0x0 */ 
    "REG_STATUS",       /* 0x4 */ 
    "REG_D_FMT",        /* 0x8 */ 
    "REG_Y_ADDR",       /* 0xc */ 
    "REG_U_ADDR",       /* 0x10 */ 
    "REG_V_ADDR",       /* 0x14 */ 
    "REG_IN_FM_GS",     /* 0x18 */ 
    "REG_Y_STRIDE",     /* 0x1c */ 
    "REG_UV_STRIDE",    /* 0x20 */ 
    "REG_OUT_ADDR",     /* 0x24 */ 
    "REG_OUT_GS",       /* 0x28 */ 
    "REG_OUT_STRIDE",   /* 0x2c */ 
    "RSZ_COEF_INDEX",   /* 0x30 */ 
    "REG_CSC_C0_COEF",  /* 0x34 */ 
    "REG_CSC_C1_COEF",  /* 0x38 */ 
    "REG_CSC_C2_COEF",  /* 0x3c */ 
    "REG_CSC_C3_COEF",  /* 0x40 */ 
    "REG_CSC_C4_COEF",  /* 0x44 */
     "REG_H_LUT",        /* 0x48 */ 
    "REG_V_LUT",        /* 0x4c */ 
    "REG_CSC_OFFPARA",  /* 0x50 */
};

int jz47_dump_ipu_regs(int num)
{
  int i, total;
  if (num >= 0)
  {
    //printf ("ipu_reg: %s: 0x%x\n", ipu_regs_name[num >> 2], REG32(ipu_vbase + num));
  	return 1;
  }
  if (num == -1)
  {
    total = sizeof (ipu_regs_name) / sizeof (char *);
    for (i = 0; i < total; i++)
      printf ("ipu_reg: %s: 0x%x\n", ipu_regs_name[i], REG32(ipu_vbase + (i << 2)));
  }
  if (num == -2)
  {
    for (i = 0; i < IPU_LUT_LEN; i++)
      printf ("ipu_H_LUT(%d): 0x%x\n", i, REG32(ipu_vbase + HRSZ_LUT_BASE + i * 4));
    for (i = 0; i < IPU_LUT_LEN; i++)
      printf ("ipu_V_LUT(%d): 0x%x\n", i, REG32(ipu_vbase + VRSZ_LUT_BASE + i * 4));
  }
  return 1;
}

/* set ipu data format.  */
int jz47_set_ipu_csc_cfg (SwsContext *c, int outW, int outH, int Wdiff, int Hdiff)
{
  unsigned int in_fmt = 0, out_fmt = 0;
  int out_width, out_height;

  const int dstFormat= c->dstFormat;
  const int srcFormat= c->srcFormat;

  REG32(ipu_vbase + REG_CTRL) |= CSC_EN;

  switch (srcFormat)
  {
    case PIX_FMT_YUV420P:
      Hdiff = (Hdiff + 1) & ~1;
      Wdiff = (Wdiff + 1) & ~1;
      in_fmt = INFMT_YCbCr420;
      break;

    case PIX_FMT_YUV422P:
      Wdiff = (Wdiff + 1) & ~1;
      in_fmt = INFMT_YCbCr422;
      break;

    case PIX_FMT_YUV444P:
      in_fmt = INFMT_YCbCr444;
      break;

    case PIX_FMT_YUV411P:
      in_fmt = INFMT_YCbCr411;
      break;
  }

  out_width =outW;
  out_height=outH;
 
 printf ("++++++++0 outW=%d dstFormat=%d\n", outW, dstFormat);
  switch (dstFormat)
  {
	  //case PIX_FMT_RGB32:
  case PIX_FMT_RGBA32:
	  out_fmt = OUTFMT_RGB888;
	  outW = outW << 2;
	  break;
	  
  case PIX_FMT_RGB555:
	  out_fmt = OUTFMT_RGB555;
	  outW = outW << 1;
	  break;
	
  case PIX_FMT_RGB565:
  case PIX_FMT_BGR565:
	  out_fmt = OUTFMT_RGB565;
	  outW = outW << 1;
	  break;
  default:
	  printf("no support out format, check jz47_set_ipu_csc_cfg()\n");	  
  }

  //printf ("++++++++1 outW=%d out_fmt=%d\n", outW, out_fmt);
  
// Set GS register
  REG32(ipu_vbase + REG_IN_FM_GS) = IN_FM_W(c->srcW - Wdiff) | IN_FM_H((c->srcH - Hdiff) & ~1);
  REG32(ipu_vbase + REG_OUT_GS) = OUT_FM_W(outW) | OUT_FM_H(outH);

// set Format
  REG32(ipu_vbase + REG_D_FMT) = in_fmt | out_fmt;

// set parameter
  REG32(ipu_vbase + REG_CSC_C0_COEF) = YUV_CSC_C0;
  REG32(ipu_vbase + REG_CSC_C1_COEF) = YUV_CSC_C1;
  REG32(ipu_vbase + REG_CSC_C2_COEF) = YUV_CSC_C2;
  REG32(ipu_vbase + REG_CSC_C3_COEF) = YUV_CSC_C3;
  REG32(ipu_vbase + REG_CSC_C4_COEF) = YUV_CSC_C4;
  REG32(ipu_vbase + REG_CSC_OFFPARA) = YUV_CSC_OFFPARA;

  return 0;
}


int init_ipu_ratio_table ()
{
  int i, j, cnt;
  float r, min, diff;

  // orig table, first calculate
   for (i = 1; i <= (IPU_LUT_LEN); i++)
    for (j = 1; j <= (IPU_LUT_LEN); j++)
    {
      ipu_ratio_table [(i - 1) * 20 + j - 1].ratio = i / (float)j;
      ipu_ratio_table [(i - 1) * 20 + j - 1].n = i;
      ipu_ratio_table [(i - 1) * 20 + j - 1].m = j;
    }

// Eliminate the ratio greater than 1:2
  for (i = 0; i < (IPU_LUT_LEN) * (IPU_LUT_LEN); i++)
    if (ipu_ratio_table[i].ratio < 0.4999)
      ipu_ratio_table[i].n = ipu_ratio_table[i].m = -1;

// eliminate the same ratio
  for (i = 0; i < (IPU_LUT_LEN) * (IPU_LUT_LEN); i++)
    for (j = i + 1; j < (IPU_LUT_LEN) * (IPU_LUT_LEN); j++)
    {
      diff = ipu_ratio_table[i].ratio - ipu_ratio_table[j].ratio;
      if (diff > -0.001 && diff < 0.001)
      {
        ipu_ratio_table[j].n = -1;
        ipu_ratio_table[j].m = -1;
      }
    }

// reorder ipu_ratio_table
cnt = 0;
  for (i = 0; i < (IPU_LUT_LEN) * (IPU_LUT_LEN); i++)
    if (ipu_ratio_table[i].n != -1)
    {
      if (cnt != i)
        ipu_ratio_table[cnt] = ipu_ratio_table[i];
      cnt++;
    }
  ipu_rtable_len = cnt;

#if 0
  printf ("ipu_rtable_len = %d\n", ipu_rtable_len);
  for (i = 1; i <= (IPU_LUT_LEN); i++)
	  for (j = 1; j <= (IPU_LUT_LEN); j++) {
		  int aaa = (i - 1) * 20 + j - 1;
		  printf("[i=%d j=%d pos=%d] = {%f : %d : %d}\n",i-1,j-1,aaa,ipu_ratio_table[aaa].ratio,ipu_ratio_table[aaa].n,ipu_ratio_table[aaa].m);
	  }
#endif

  return 0;
}

int find_ipu_ratio_factor (float ratio)
{
  int i, sel; 
  float diff, min;
  sel = ipu_rtable_len;

  for (i = 0; i < ipu_rtable_len; i++)
  {
    if (ratio > ipu_ratio_table[i].ratio)
      diff = ratio - ipu_ratio_table[i].ratio;
    else
      diff = ipu_ratio_table[i].ratio - ratio;

    if (diff < min || i == 0)
    {
      min = diff;
      sel = i;
    }
  }

  printf ("resize: sel = %d, n=%d, m=%d\n", sel, ipu_ratio_table[sel].n,
          ipu_ratio_table[sel].m);
  return sel;
}

int resize_lut_cal (int srcN, int dstM, int upScale, rsz_lut lut[]);
int resize_out_cal (int insize, int outsize, int srcN, int dstM, int upScale, int *diff);
int jz47_set_ipu_resize (SwsContext *c, int *outWp, int *outHp,
                         int *Wdiff, int *Hdiff)
{
  int Hsel = 0, Wsel = 0;
  int srcN, dstM, width_up, height_up;
  int Height_lut_max, Width_lut_max;
  int i;

  if (rsize_w == 0)
    rsize_w = c->dstW;
  if (rsize_h == 0)
    rsize_h = c->dstH;
    
  rsize_w = (rsize_w > fb_w) ? fb_w : rsize_w;
  rsize_h = (rsize_h > fb_h) ? fb_h : rsize_h;

  *outWp = rsize_w;
  *outHp = rsize_h;
  *Wdiff = *Hdiff = 0;

  // orig size: c->srcW, c->srcH
  printf ("c->srcW = %d, c->srcH=%d, rsize_w=%d, rsize_h=%d\n", 
          c->srcW, c->srcH, rsize_w, rsize_h);

  disable_rsize (ipu_vbase);
// Don't need do resize ?
  if ((c->srcW == rsize_w) && (c->srcH == rsize_h) || (rsize_w > 2 * c->srcW)
      || (rsize_h > 2 * c->srcH))
  {
    return 0;
  }

// init the resize factor table
  if (!ipu_rtable_init)
  {
    init_ipu_ratio_table ();
    ipu_rtable_init = 1;
  }

// enable resize
  if (c->srcW != rsize_w)
    enable_hrsize (ipu_vbase);

  if (c->srcH != rsize_h)
    enable_vrsize (ipu_vbase);

// get the resize factor
  Wsel = find_ipu_ratio_factor(((float) c->srcW)/rsize_w);
  Hsel = find_ipu_ratio_factor(((float) c->srcH)/rsize_h);

// set IPU_CTRL register
  width_up  = rsize_w >= c->srcW;
  height_up = rsize_h >= c->srcH;
  REG32(ipu_vbase + REG_CTRL) |= (height_up << V_SCALE_SHIFT) | (width_up << H_SCALE_SHIFT);

// set IPU_INDEX register
  Width_lut_max  = width_up  ? ipu_ratio_table[Wsel].m : ipu_ratio_table[Wsel].n;
  Height_lut_max = height_up ? ipu_ratio_table[Hsel].m : ipu_ratio_table[Hsel].n;
  REG32(ipu_vbase + REG_RSZ_COEF_INDEX) =   ((Height_lut_max - 1) << VE_IDX_SFT) 
                                          | ((Width_lut_max - 1)  << HE_IDX_SFT);

// calculate out W/H and LUT
  srcN = ipu_ratio_table[Wsel].n;
  dstM = ipu_ratio_table[Wsel].m;
  *outWp = resize_out_cal (c->srcW, rsize_w, srcN, dstM, width_up,  Wdiff);
  resize_lut_cal (srcN, dstM, width_up,  h_lut);

  srcN = ipu_ratio_table[Hsel].n;
  dstM = ipu_ratio_table[Hsel].m;
  *outHp = resize_out_cal (c->srcH, rsize_h, srcN, dstM, height_up, Hdiff);
  resize_lut_cal (srcN, dstM, height_up, v_lut);

#if 0
  int aaa;
  for (aaa = 0; aaa < IPU_LUT_LEN; aaa++)
	  printf("h_lut[%d] = { %d : %d : %d }\n",aaa,h_lut[aaa].coef,h_lut[aaa].in_n,h_lut[aaa].out_n);
   for (aaa = 0; aaa < IPU_LUT_LEN; aaa++)
	   printf("v_lut[%d] = { %d : %d : %d }\n",aaa,v_lut[aaa].coef,v_lut[aaa].in_n,v_lut[aaa].out_n);
#endif

// set IPU LUT register
  REG32(ipu_vbase + VRSZ_LUT_BASE) = (1 << START_N_SFT);
  for (i = 0; i < Height_lut_max; i++)
    REG32(ipu_vbase + VRSZ_LUT_BASE) = (v_lut[i].coef << W_COEF_SFT)
          | (v_lut[i].in_n << IN_N_SFT) | (v_lut[i].out_n  << OUT_N_SFT);

  REG32(ipu_vbase + HRSZ_LUT_BASE) = (1 << START_N_SFT);
  for (i = 0; i < Width_lut_max; i++)
    REG32(ipu_vbase + HRSZ_LUT_BASE) = (h_lut[i].coef << W_COEF_SFT)
          | (h_lut[i].in_n << IN_N_SFT) | (h_lut[i].out_n  << OUT_N_SFT);

  return 0;
}

int resize_out_cal (int insize, int outsize, int srcN, int dstM, 
                    int upScale, int *diff)
{
 float calsize;
  int  delta;
  float tmp, tmp2;
  delta = 1;

  do {
    tmp = (insize - delta) * dstM / (float)srcN;
    tmp2 = tmp  * srcN / dstM;
    if (upScale)
    {
      if (tmp2 == insize - delta)
        calsize = tmp + 1;
      else
        calsize = tmp + 2;
    }
    else   // down Scale
    {
      if (tmp2 == insize - delta)
        calsize = tmp;
      else
        calsize = tmp + 1;
    }
    delta++;
  } while (calsize > outsize);

  *diff = delta - 2;

  return calsize;
}

int resize_lut_cal (int srcN, int dstM, int upScale, rsz_lut lut[])
{
  int i, t, x;
  float w_coef, factor, factor2;

  if (upScale)
  {
    for (i = 0, t=0; i < dstM; i++)
    {
      factor = (float) (i * srcN) / (float)dstM;
      factor2 = factor - (int)factor;
      w_coef = 1.0  - factor2;
      lut[i].coef = ((unsigned int)(512.0 * w_coef) & W_COEF_MSK);
// calculate in & out
      lut[i].out_n = 1;
      if (t <= factor)
      {
        lut[i].in_n = 1;
        t++;
      }
      else
       lut[i].in_n = 0;
    } // end for
  }
  else
  {
    for (i = 0, t = 0, x = 0; i < srcN; i++)
    {
      factor = (float) (t * srcN + 1) / (float)dstM;
      if (dstM == 1)
      {
// calculate in & out
        lut[i].coef =  (i == 0) ? 256 : 0;
        lut[i].out_n = (i == 0) ? 1  : 0;
      }
      else 
      if (((t * srcN + 1) / dstM - i) >= 1)
        lut[i].coef = 0;
      else
      if (factor - i == 0)
      {
        lut[i].coef = 512;
        t++;
      }
      else
      {
        factor2 = (float) (t * srcN) / (float)dstM;
        factor = factor - (int)factor2;
        w_coef = 1.0  - factor;
        lut[i].coef = ((unsigned int)(512.0*w_coef) & W_COEF_MSK);
        t++;
      }
// calculate in & out
      lut[i].in_n = 1;
      if (dstM != 1)
      {
        if (((x * srcN + 1) / dstM - i) >= 1)
          lut[i].out_n = 0;
        else
        {
          lut[i].out_n = 1;
          x++;
        }
      }
    } /* for end down Scale*/
  } /* else upScale */
  return 0;
}

int jz47_ipu_init (struct vf_instance_s* vf)
{
  SwsContext *c = vf->priv->ctx;
  int outW, outH, Wdiff, Hdiff;

  outW= c->dstW;
  outH= c->dstH;

  if (!ipu_maped)
  {
    ipufd = open ("/dev/mem", O_RDWR);
    if (ipufd < 0) {
      printf("++ open /dev/mem error. program aborted. ++\n");
      exit (1);
    }
    ipu_vbase = mmap((void *)0, IPU__SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, ipufd, IPU__OFFSET);
    ipu_maped = 1;
  }

  if (!ipu_inited)
  {
//init
    stop_ipu  (ipu_vbase);
    reset_ipu (ipu_vbase);  
    clear_end_flag (ipu_vbase);

//disable irq
    disable_irq(ipu_vbase);

// set IPU resize field
    jz47_set_ipu_resize (c, &outW, &outH, &Wdiff, &Hdiff);

// set CSC parameter and format
    jz47_set_ipu_csc_cfg(c, outW, outH, Wdiff, Hdiff);
    ipu_image_completed = 0;
// set out frame buffer
#ifdef NEED_COPY_IMGBUF
    img_ptr = (unsigned char *)jz4740_alloc_frame (32, fbmemlen);
    REG32(ipu_vbase + REG_OUT_ADDR) = get_phy_addr ((unsigned int)img_ptr); 
#else
    REG32(ipu_vbase + REG_OUT_ADDR) = phy_fb;
#endif
    REG32(ipu_vbase + REG_OUT_STRIDE) = fb_line_len;
    ipu_inited = 1;
    //ipu_size_cfg = 0;
   }

   if (ipu_size_cfg)
   {
	outW= c->srcW;
  	outH= c->srcH;
	switch(ipu_size_cfg)
   	{
		   case MP_IMAGE_TYPE_CUSTORM:
		    break;
		   case MP_IMAGE_TYPE_INITSIZE:
		   	if((outH <= FB_LCD_HEIGHT) && (outW <= FB_LCD_WIDTH))
		   	{	
		   		rsize_w = outW;
    			rsize_h = outH;
    			out_x = (FB_LCD_WIDTH - outW) / 2;
    			out_y = (FB_LCD_HEIGHT - outH) / 2;    			
    		}else
    			eqscale(outW,outH);
		   	break;
		   case MP_IMAGE_TYPE_EQSIZE:
		   	  eqscale(outW,outH);
		   	  break;
		   	break;
		   case MP_IMAGE_TYPE_FULLSCREEN:
		   		fullscreen(outW,outH);
		   	break;	
		}
// set IPU resize field
	jz47_set_ipu_resize (c, &outW, &outH, &Wdiff, &Hdiff);

// set CSC parameter and format
    jz47_set_ipu_csc_cfg(c, outW, outH, Wdiff, Hdiff);
    frame_offset = (out_x + out_y * FB_LCD_WIDTH) * LCD_BPP_BYTE;
    out_w = outW;
    out_h = outH;
   
    ipu_size_cfg = 0;  
    ipu_size_cfg = 0;
  }

   //jz47_dump_ipu_regs(-1);
   //ioctl(fbfd, FBIOPRINT_REG, NULL);
  return 0;
  
}

void eqscale(int w,int h)
{
	int xscale,yscale;
	int scale;

	xscale = w * 1000 / FB_LCD_WIDTH;
	yscale = h * 1000 / FB_LCD_HEIGHT;

	scale = xscale > yscale ? xscale : yscale;

	if(scale <= 500) scale = 500;
	rsize_w = w * 1000 / scale;
	rsize_h = h * 1000 / scale;
	
	if(rsize_h > FB_LCD_HEIGHT) rsize_h = FB_LCD_HEIGHT;
	if(rsize_w > FB_LCD_WIDTH) rsize_w = FB_LCD_WIDTH;
				
	out_x = (FB_LCD_WIDTH - rsize_w) / 2;
	out_y = (FB_LCD_HEIGHT - rsize_h) / 2;

		
}
static void fullscreen(int w,int h)
{
	int xscale,yscale;
	int scale;
	int scrw,scrh;
	xscale = w * 1000 / FB_LCD_WIDTH;
	yscale = h * 1000 / FB_LCD_HEIGHT;
	
	if(xscale <= 500)
		rsize_w = w * 1000 / 500;
	else
		rsize_w = FB_LCD_WIDTH;
	if(yscale <= 500)
		rsize_h = h * 1000 / 500;
	else
		rsize_h = FB_LCD_HEIGHT;	
	
	if(rsize_h > FB_LCD_HEIGHT) rsize_h = FB_LCD_HEIGHT;
	if(rsize_w > FB_LCD_WIDTH) rsize_w = FB_LCD_WIDTH;
		
	out_x = (FB_LCD_WIDTH - rsize_w) / 2;
	out_y = (FB_LCD_HEIGHT - rsize_h) / 2;

		
}

void toggle_jz47_tlb(void)
{
	int cur_pid = 0;
	unsigned char cmdbuf[100];

	//printf("\n\n*** toggle_flag=%d***\n\n",toggle_flag);
	if (!toggle_flag && memdev[0].vaddr && memdev[0].paddr) {
		toggle_flag = 1;
		cur_pid = getpid();
		
		sprintf(cmdbuf, "echo 00%08x 00%08x 00%08x 00%08x > %s", cur_pid, memdev[0].vaddr, memdev[0].paddr, 0x400000, "/proc/jz/ipu");
		
		//printf("toggle : system call command: cmdbuf=%s\n",cmdbuf);
		system(cmdbuf);
	}
	
	return;
}

void free_jz47_tlb(void)
{
	int cur_pid = 0;
	unsigned char cmdbuf[100];

	if (toggle_flag) {
		sprintf (cmdbuf, "echo %s > %s", "release tlb", "/proc/jz/ipu");
		//printf("free : system call command: cmdbuf=%s\n",cmdbuf);
		system (cmdbuf);
		jz4740_free_devmem();
		toggle_flag = 0;
	}
	
	return;
}

void  ipu_image_start()
{
  jz4740_free_devmem();
  ipu_inited = 0;
  ipu_image_completed = 0;
  rsize_w = 0;
  rsize_h = 0;
  out_x = out_y = 0;
  frame_offset = 0;
}

void  ipu_outsize_changed(int x,int y,int w, int h)
{
	out_x = x;
	out_y = y;
	if ((w==0) && (h==0))
	{
		if ((rsize_w == 0) && ( rsize_h == 0)) return;
		rsize_w = 0;
		rsize_h = 0;
		ipu_size_cfg = 1;	
	}
	else 
    { 
    	if (rsize_w != w || rsize_h != h) {
    		rsize_w = w;
    		rsize_h = h;    		
    		ipu_size_cfg = 1;
    	}
    }
}


void  copy_image_to_fb ()
{  
   memcpy ((void *)frame_buffer, (void *)img_ptr, fbmemlen);  
   return;
}

int jz47_put_image_with_ipu (struct vf_instance_s* vf, mp_image_t *mpi, double pts)
{
  unsigned int paddr;
  SwsContext *c = vf->priv->ctx;
unsigned int img_area = c->srcW * c->srcH;

  if (!get_fbinfo_already)
  {
    get_fbaddr_info();
    get_fbinfo_already = 1;
  }
 if (!ipu_maped)
  {
    ipufd = open ("/dev/mem", O_RDWR);
    if (ipufd < 0) {
      printf("++ open /dev/mem error. program aborted. ++\n");
      exit (1);
    }
    ipu_vbase = mmap((void *)0, IPU__SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, ipufd, IPU__OFFSET);
  
    ipu_maped = 1;
    ipu_enable(ipu_vbase);
  }

 while ((!polling_end_flag(ipu_vbase)) && ipu_is_run(ipu_vbase)) {
	 /*usleep()*/;
 }

  stop_ipu(ipu_vbase);
  clear_end_flag(ipu_vbase);

  jz47_ipu_init (vf);
#ifdef NEED_COPY_IMGBUF
  if (ipu_image_completed)
    copy_image_to_fb ();
#endif

// set Y(mpi->planes[0]), U(mpi->planes[1]), V addr (mpi->planes[2])
  paddr = get_phy_addr ((unsigned int)mpi->planes[0]);
  if (paddr == 0)
  {
    printf ("++ Can not found Y buffer(0x%x) physical addr since addr errors +++\n",
            (unsigned int)mpi->planes[0]);
    exit(1);
    
  }
  REG32(ipu_vbase + REG_Y_ADDR) = paddr;

// set U addr register (mpi->planes[1])
  paddr = get_phy_addr ((unsigned int)mpi->planes[1]);
  if (paddr == 0)
  {
    printf ("++ Can not found U buffer(0x%x) physical addr since addr errors +++\n",
            (unsigned int)mpi->planes[1]);
    exit(1);
  }
  REG32(ipu_vbase + REG_U_ADDR) = paddr;

// set V addr register (mpi->planes[2])
  paddr = get_phy_addr ((unsigned int)mpi->planes[2]);
  if (paddr == 0)
  {
    printf ("++ Can not found V buffer(0x%x) physical addr since addr errors +++\n",
            (unsigned int)mpi->planes[2]);
    exit(1);
  }
  REG32(ipu_vbase + REG_V_ADDR) = paddr;

// set Y(mpi->stride[0]) U(mpi->stride[1]) V(mpi->stride[2]) stride
  REG32(ipu_vbase + REG_Y_STRIDE) = mpi->stride[0];
  REG32(ipu_vbase + REG_UV_STRIDE) = U_STRIDE(mpi->stride[1]) | V_STRIDE(mpi->stride[2]);

  // flush the dcache
  memset (dcache, 0x2, 0x4000);

// start ipu
  run_ipu(ipu_vbase);
  ipu_image_completed = 1;
 
  return 1;
}

// copy from vf_scale.c

static void scale(struct SwsContext *sws1, struct SwsContext *sws2, uint8_t *src[3], int src_stride[3], int y, int h, 
                  uint8_t *dst[3], int dst_stride[3], int interlaced){
    if(interlaced){
        int i;
        uint8_t *src2[3]={src[0], src[1], src[2]};
        uint8_t *dst2[3]={dst[0], dst[1], dst[2]};
        int src_stride2[3]={2*src_stride[0], 2*src_stride[1], 2*src_stride[2]};
        int dst_stride2[3]={2*dst_stride[0], 2*dst_stride[1], 2*dst_stride[2]};

        sws_scale_ordered(sws1, src2, src_stride2, y>>1, h>>1, dst2, dst_stride2);
        for(i=0; i<3; i++){
            src2[i] += src_stride[i];
            dst2[i] += dst_stride[i];
        }
        sws_scale_ordered(sws2, src2, src_stride2, y>>1, h>>1, dst2, dst_stride2);
    }else{
        sws_scale_ordered(sws1, src, src_stride, y, h, dst, dst_stride);
    }       
}

static int visual = 0;
void drop_image()
{
	visual = 0;
}

#if 0
int jz47_put_image(struct vf_instance_s* vf, mp_image_t *mpi, double pts)
{
    mp_image_t *dmpi=mpi->priv;
    //printf("jz4740: processing whole frame! dmpi=%p flag=%d\n",
    //	dmpi, (mpi->flags&MP_IMGFLAG_DRAW_CALLBACK));
   
  if(!(mpi->flags&MP_IMGFLAG_DRAW_CALLBACK && dmpi)){

#if 0
    // hope we'll get DR buffer:
    dmpi=vf_get_image(vf->next,vf->priv->fmt,
	MP_IMGTYPE_TEMP, MP_IMGFLAG_ACCEPT_STRIDE | MP_IMGFLAG_PREFER_ALIGNED_STRIDE,
	vf->priv->w, vf->priv->h);
#endif
    if(mpi->pict_type == 1)
	    drop_visual = 0;
    if( (drop_visual == 0) && (! jz47_put_image_with_ipu (vf, mpi, pts)))
	    scale(vf->priv->ctx, vf->priv->ctx, mpi->planes,mpi->stride,0,mpi->h,dmpi->planes,dmpi->stride, vf->priv->interlaced);
  }
#if 0
    if(vf->priv->w==mpi->w && vf->priv->h==mpi->h){
	    // just conversion, no scaling -> keep postprocessing data
	    // this way we can apply pp filter to non-yv12 source using scaler
	    vf_clone_mpi_attributes(dmpi, mpi);
    }

    if(vf->priv->palette) dmpi->planes[1]=vf->priv->palette; // export palette!
    
    return vf_next_put_image(vf,dmpi, pts);
#else
    return 1;
#endif
}
#else
int jz47_put_image(struct vf_instance_s* vf, mp_image_t *mpi, double pts)
{
	  mp_image_t *dmpi=mpi->priv;
    //printf("jz4740: processing whole frame! dmpi=%p flag=%d\n",
    //	dmpi, (mpi->flags&MP_IMGFLAG_DRAW_CALLBACK));
#if 1
    if (put_image_cnt <= 1) {
	    put_image_cnt ++;
	    if (put_image_cnt == 2)
		    toggle_jz47_tlb();
    }
#endif
  if(!(mpi->flags&MP_IMGFLAG_DRAW_CALLBACK && dmpi)){

    // hope we'll get DR buffer:
    //dmpi=vf_get_image(vf->next,vf->priv->fmt,
	//MP_IMGTYPE_TEMP, MP_IMGFLAG_ACCEPT_STRIDE | MP_IMGFLAG_PREFER_ALIGNED_STRIDE,
	//vf->priv->w, vf->priv->h);
    if(mpi->pict_type == 1)
    		visual = 1;
    if(visual)
		jz47_put_image_with_ipu (vf, mpi, pts);
    //if (!jz47_put_image_with_ipu (vf, mpi, pts))
      //scale(vf->priv->ctx, vf->priv->ctx, mpi->planes,mpi->stride,0,mpi->h,dmpi->planes,dmpi->stride, vf->priv->interlaced);
  }
  return 1;

    //if(vf->priv->w==mpi->w && vf->priv->h==mpi->h){
	//// just conversion, no scaling -> keep postprocessing data
	//// this way we can apply pp filter to non-yv12 source using scaler
    //    vf_clone_mpi_attributes(dmpi, mpi);
    //}
    //
    //if(vf->priv ->palette) dmpi->planes[1]=vf->priv->palette; // export palette!
    
    return vf_next_put_image(vf,dmpi,pts);
}

#endif
#endif

