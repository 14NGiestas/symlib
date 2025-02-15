
# Set up conditional compilation so that one Makefile can handle
# multiple platforms/compilers. Branch according to an environmental
# variable F90. I wish someone would show me a better way of doing this.

ifeq (${F90},) # Set gfortran as a default if F90 is not set
  F90 = gfortran
#  error:  echo Warning: environmental variable "F90" not set. Using gfortran
endif
ifeq (${F90},gfortran)  # free fortran compiler
  FFLAGS =  -g -fbounds-check -fPIC -pedantic -Wall -ffree-line-length-none
  FOUND = true
endif

ifeq (${F90},ifort)  # Intel compiler
  ifeq (${DEBUG},false)
     FFLAGS =  -O3 -fPIC
     FOUND = true
  endif
  ifeq (${DEBUG},true)
     FFLAGS =  -g -error-limit 7 -traceback -check bounds -check uninit -check pointers -fp-stack-check  -warn -heap-arrays -fpic
     FOUND = true
  endif
  ifeq (${DEBUG},)
     FFLAGS =  -g -error-limit 7 -traceback -check bounds -warn -heap-arrays -fpic
     FOUND = true
  endif

endif

ifeq (${F90},ifc)  # Intel compiler
  F90 =  /opt/intel/fc/9.1.040/bin/ifort
  FFLAGS =  -g -fPIC -error-limit 7 -traceback -check bounds -warn -heap-arrays
  FOUND = true
endif
ifeq (${F90},xlf90) # IBM compiler
  FFLAGS = -g -C -fPIC -qsuffix=f=f90
  FOUND = true
endif
ifeq (${F90},f95) # Absoft PPC compiler
  FFLAGS = -Rb -Rc  -z2 -ea -fPIC
# B80 entry into each subroutine  ; Rb bounds; Rc array conformance
  FOUND = true
endif

ifeq (${F90},)  # If the variable isn't set, make sure compilation bombs
error:
	echo Error: environmental variable "F90" not set! Use make F90=[gfortran|ifort]
endif
ifneq (${FOUND},true) # If it's set but no matching flags then bomb
error:
	echo Error: makefile doesn\'t have flags for this compiler; use make F90=[gfortran|ifort]
endif

SRC = num_types.f90 utilities.f90 numerical_utilities.f90	\
vector_matrix_utilities.f90 symmetry.f90 compare_structures.f90 \
combinatorics.f90 rational_mathematics.f90 group_theory.f90 itertools.f90 \
classes.f90 spacegroup.f90
OBJS = ${SRC:.f90=.o}


.SUFFIXES :
.SUFFIXES :  .f .f90 .f95 .o

all: libutils.a libsym.a libcomparestructs.a librational.a \
     libcombinatorics.a

libutils.a: num_types.o utilities.o numerical_utilities.o \
            vector_matrix_utilities.o
	ar ru $@ $?
	ranlib  $@

libutils.so:  num_types.o utilities.o numerical_utilities.o \
              vector_matrix_utilities.o
	ifort -dynamiclib -fpic -o libutils.so num_types.f90 utilities.f90 numerical_utilities.f90 vector_matrix_utilities.f90
#	ar ru $@ $?
#	ranlib  $@

libsym.a: symmetry.o group_theory.o itertools.o classes.o
	ar ru $@ $?
	ranlib $@

librational.a: rational_mathematics.o
	ar ru $@ $?
	ranlib $@

libcombinatorics.a: combinatorics.o
	ar ru $@ $?
	ranlib $@

libcomparestructs.a: compare_structures.o
	ar ru $@ $?
	ranlib $@

compare.x: compare.o compare_driver.o
	${F90} ${LDFLAGS} -o $@ compare.o compare_driver.o

# This exe is needed to generate spacegroup information for tests of enumlib. This is a one-off code
# but could be adjusted for a more general purpose, stand-alone spacegroup finder
spacegroup4fortpy.x: num_types.o numerical_utilities.o utilities.o vector_matrix_utilities.o \
	symmetry.o spacegroup.o
	${F90} ${LDFLAGS} -o $@ num_types.o numerical_utilities.o utilities.o vector_matrix_utilities.o \
		symmetry.o spacegroup.o

sym.x: num_types.o numerical_utilities.o utilities.o vector_matrix_utilities.o \
	symmetry.o symdriver.o
	${F90} ${LDFLAGS} -o $@ num_types.o numerical_utilities.o utilities.o vector_matrix_utilities.o \
		symmetry.o symdriver.o
	
.f95.o :
	${F90} ${FFLAGS} -c $<

.f90.o :
	${F90} ${FFLAGS} -c $<

CLEAN  = *.o *.mod *.a
clean :
	rm -f ${CLEAN}

remake:
	make clean
	make

clobber:
	rm -f  ${CLEAN}  *~ \#*
	make
