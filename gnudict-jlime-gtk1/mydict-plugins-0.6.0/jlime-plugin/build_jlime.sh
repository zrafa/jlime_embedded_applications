#!/bin/bash

g++ -fPIC -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"mydict-plugins\" -DVERSION=\"0.6.0\"  -I. -I.      -g -O2 -c plugdemo.cpp
g++ -fPIC -g -O2  -lz -o plugdemo.so -shared plugdemo.o  

