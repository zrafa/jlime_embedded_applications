# 
# Gmu Music Player
#
# Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
#
# File: nanonote.mk  Created: 100305
#
# Description: Makefile configuration (Ben NanoNote)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; version 2 of
# the License. See the file COPYING in the Gmu's main directory
# for details.
#

#DECODERS_TO_BUILD=decoders/vorbis.so decoders/musepack.so decoders/flac.so decoders/wavpack.so decoders/mpg123.so decoders/mikmod.so
DECODERS_TO_BUILD=decoders/vorbis.so decoders/musepack.so decoders/wavpack.so decoders/mikmod.so
FRONTENDS_TO_BUILD=frontends/sdl.so frontends/log.so
DEVICE=NANONOTE
CONFIG=-D_$(DEVICE)
SDL_LIB=-lSDL -lpthread -ldirectfb -ldirect -lfusion -lz -lSDL_image -lSDL_gfx
SDL_CFLAGS=-D_GNU_SOURCE=1 -D_REENTRANT
CXX=mipsel-linux-g++
CC=mipsel-linux-gcc
STRIP=mipsel-linux-strip
TOOLCHAIN_ROOT_PATH=$(shell which $(CC)|sed 's/toolchain-mipsel_gcc-4.3.3+cs_uClibc-0.9.30.1\/usr\/bin\/$(CC)//')
COPTS?=-O2 -s
CFLAGS=-msoft-float -I/usr/local/jlime/mipsel-toolchain/usr/include/SDL -I/usr/local/jlime/mipsel-toolchain/usr/include -ffast-math -fomit-frame-pointer $(SDL_CFLAGS) $(CONFIG)
LFLAGS=-s $(SDL_LIB) -L$(TOOLCHAIN_ROOT_PATH)/target-mipsel_uClibc-0.9.30.1/usr/lib -L$(TOOLCHAIN_ROOT_PATH)/target-mipsel_uClibc-0.9.30.1/root-xburst/usr/lib -L/usr/local/jlime/mipsel-toolchain/usr/lib -lpthread -lm -ldl -lgcc -Wl,-export-dynamic
DISTFILES=$(BINARY) frontends decoders themes gmu.png README.txt libs.nanonote gmu.nn COPYING gmuinput.nanonote.conf
