Build Instructions - bcg 3/4/10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# To build the Tellymate firmware:
make -C 3rdParty/tellymate-114

# To build the software for Unix (for test and debug)
scons ARCH=unix

# To build the software for AVR (incl .hex files)
scons ARCH=avr

All binaries are built in build/unix/ or build/atmega328p-20/
Except tellymate, which is built in-place.

See ../README.txt for more information about directory structure.

----
