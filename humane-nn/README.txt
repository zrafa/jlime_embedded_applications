Welcome to the Humane Informatics "Tvikia" repository!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a quick guided tour of the directory structure:

TOP LEVEL:

doc/ - documentation, business plan, notes, videos, photos
hardware/ - Active hardware design, Eagle files, BOM, etc
releases/ - Actual hardware/software releases, such as
  gerbers, BOM, fixes, notes, etc for a particular PCB run.
software/ - Software
attic/ - obsolete items we want for future reference

DIR: doc/
Required reading: design_notes.html, business_plan.html
Required Viewing: hardware_intro_a109.mp4
Suggested Browsing: NOTES.txt contains all my raw notes
           during development and should be insightful.

DIR: hardware/
bom.gnumeric - Definitive latest BOM
   ^ Note, check releases/ dir for BOM for particular PCB
eagle/ - CADSoft Eagle design files.

DIR: releases/tvikia-zc19a
zc19a is the first PCB board run revision from 12/19/09
(z = 2009, c = December (hex), 19 = date, a = revision)

This directory contains gerbers, REWORK PHOTOS, BOM,
schematics, and layout, which SHOULD BE USED DURING ASSEMBLY!

Important files in tvikia-zc19a/
ERRATA - PCB Errata, please read and add
TEST_PROCEDURE.txt - This is the PCB electrical test
   procedure for assembly and smoke test.  Provides test
   points, expected tolerances, etc.  USE DURING ASSEMBLY!

DIR: software/

software/3rdParty/
We use a couple 3rd party packages, including the Tellymate
NTSC/PAL video terminal, and the Petite FatFS SD Card
filesystem.  We also plan to use the V-USB CDC package for
USB slave functionality.

3rdParty/pfatfs/avr/
Note there are multiple copies of pfatfs for different
platforms.  3rdParty/pfatfs/avr is the copy we are using, and
have configured for our hardware!

software/uCmorse
This is my tiny morse code library used both for debugging
output and button morse input.

software/tests
Unit tests for various components.

software/data
Mostly no-longer-used font data.

software/apps
Actual mini-applications and test programs (as vaguely
differentiated from Unit Tests).

software/scratch
Complete scratch-pad area for experimentation and non-production code.

software/pfatfs-stdio
My extension to Petite FatFS which allows it to run under
POSIX using std libc calls into a FAT image.

software/bgtree
My B-tree "database" implementation.

software/preprocess
Wikipedia pre-processing and compression scripts.  

software/build 
SCons builds all binaries under this directory, except for
the tellymate package (which you must build in-place)

Have a nice day! - BCG 2/10/10
------
