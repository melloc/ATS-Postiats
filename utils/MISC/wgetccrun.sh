#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

MY_CFLAGS_LIBS=

######
#
# echo $1
#
######
#
${WGET} -q -O - $1 | \
${TCCRUN} \
-DATS_MEMALLOC_LIBC \
-I${PATSHOME} \
-I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib \
 $MY_CFLAGS_LIBS -
#
###### end of [wgetccrun.sh] ######
