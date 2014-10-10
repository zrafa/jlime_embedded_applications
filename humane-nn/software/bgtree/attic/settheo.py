#!/usr/bin/env python

targets = [{n:"bgTreeCmd", t:"exe"}, {n:"bgTest", t:"exe"}, {n:"libbgTree",t:"so"}]

cc = "gcc"
cflags = "-std=c99" "-Winvalid-pch" "-Wall" "-Wno-long-long" "-pedantic"   "-I/usr/include/SDL"

generator_cpp = [
    {inputs: [{"cc":cc}, {"cflags":cflags}, {"cfile":{t:"c"}}]
    {template: "gcc \1 \2 \3"}
    ]

