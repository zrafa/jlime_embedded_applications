./configure
make
make clean

. /usr/local/jlime/mipsel-toolchain/usr/bin/setup-env  
set_makefile.sh
make

gcc  -g -O2 -Wall -W  -o torsmo   common.o fs.o linux.o mail.o mixer.o torsmo.o x11.o -L/usr/local/jlime/mipsel-toolchain/usr/lib -lX11
