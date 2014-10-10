/* PS/2 Keyboard Interface */
#ifndef PS2_H
#define PS2_H 1

extern uint8_t g_portc_old;
extern uint8_t g_kbd_shift;
extern uint8_t g_kbd_parity;
extern uint8_t g_kbd_count;
#define KBD_BUF_SIZE 16
extern uint8_t g_kbd_buf[KBD_BUF_SIZE];
extern uint8_t g_kbd_buf_len;
extern uint8_t g_kbd_buf_start;

void kbd_init(void);

void kbd_suspend(void);

void kbd_resume(void);

void kbd_handler(void);

#endif
