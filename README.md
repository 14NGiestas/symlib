# Note: fpm package: removed test folders

# symlib
Symmetry-related routines for cluster expansion and other codes that rely on symmetries of lattices
and crystals. This code was started by GLWH in 1997 with help from Harold Stokes (Mr. Isotropy, see
[iso.byu.edu](http://iso.byu.edu/iso/isodistort.php)). It now includes a number of numerical and
combinatorial routines that have been useful in developing UNCLE (the UNiversal CLuster Expansion code). The [enum
project](https://github.com/glwhart/enum4) also relies on this library.  

Some key algorithms found in `symlib` include:

- `HermiteNormalForm` algorithm that finds the Hermite Normal Form of a
3x3 integer matrix.

- `SmithNormalForm` algorithm that finds the Smith Normal Form of a
3x3 integer matrix.

- `get_spaceGroup` which finds the space group of a given crystal.

- `get_lattice_pointGroup` which finds the point group of a lattice.

- `minkowski_reduce_basis` which performs minkowski reduction on a
  lattice to minimize the lengths of each vectors in the basis.

## Compiling `symlib`

`symlib` ships with a Makefile in the `src/` directory. Although it has several rules for different
use cases, for a quickstart, just type: 

```
cd src/
make F90=[gfortran|ifort]
```

This will generate libraries `libutils.a libsym.a libcomparestructs.a librational.a
libcombinatorics.a`. For API references on these libraries (which have to still be generated using
`fortpy`), check out the wiki page. 

## Running the Unit Tests

`symlib` is ~10% unit tested. Tests can be run using
[fortpy](https://github.com/rosenbrockc/fortpy). We recommend using a virtualenv to run all the unit
tests. 

```
pip install fortpy
cd symlib
runtests.py src/
```

This will compile a series of drivers to test the `symlib` codes in a directory at `staging/`. Any
errors or warnings generated will be redirected to `stdout`. 

## Troubleshooting

So far, no one has *ever* had any problems installing and using this code :D.

## Code sources

The files src/classes.f90 and src/itertools.f90 were taken from the [Polya](https://github.com/rosenbrockc/polya) respository.
