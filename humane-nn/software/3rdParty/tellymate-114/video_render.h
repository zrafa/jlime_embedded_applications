/*
Copyright (c) 2009, Nigel Batten.
Contactable at <firstname>.<lastname>@mail.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

	1.	Redistributions of source code must retain the above copyright
		notice, this list of conditions and the following disclaimer.
	2.	Redistributions in binary form must reproduce the above copyright
		notice, this list of conditions and the following disclaimer in the
		documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
COPYRIGHT HOLDER BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.

===============================================
*/

#ifndef _VIDEO_RENDER__H
#define _VIDEO_RENDER__H
#include "video.h"

typedef void render_handler( void ) ;// a routine to handle display rendering for a scanline.

extern render_handler render_handler_nondisplay ;
extern render_handler *g_render_handler ;

#endif