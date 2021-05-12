#!/bin/bash
  
# Builds all relevant chimes_calculator executables/library files
# Run with:
# ./install.sh
# or
# ./install.sh <debug option (0 or 1)> <install prefix (full path)> <verbosity option (0 or 1)> <MPI option (0 or 1)>



DEBUG=${1-0}  # False (0) by default.
PREFX=${2-""} # Empty by default
VERBO=${3-1}  # Verbosity set to 1 by default
DOMPI=${4-1}  # Compile with MPI support by default


# Clean up previous installation,

./uninstall.sh $PREFX

# Move into build directory

mkdir build
cd build

# Generate cmake flags

my_flags=""

if [ ! -z $PREFX ] ; then
        my_flags="-DCMAKE_INSTALL_PREFIX=${PREFX}"
fi

if [ $DEBUG -eq 1 ] ;then
        my_flags="${my_flags} -DDEBUG=1" 
else
        my_flags="${my_flags} -DDEBUG=0" 
fi

if [ $VERBO -eq 1 ] ;then
        my_flags="${my_flags} -DVERBOSITY=1" 
else
        my_flags="${my_flags} -DVERBOSITY=0" 
fi

if [ $DOMPI -eq 1 ] ;then
        my_flags="${my_flags} -DUSE_MPI=1" 
else
        my_flags="${my_flags} -DUSE_MPI=0" 
fi


echo "compiling with flags: $my_flags"


# Setup, make and install

cmake $my_flags ..
make

if [ ! -z $PREFX ] ; then
        make install
fi

cd ..
      