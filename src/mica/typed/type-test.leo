import
  mica typed base
  mica typed type

begin
  comment type-size

  define-syntax rules
    when
      check-type-size: in, out
      check equal?
        type-size: 7, syntax in
        out

  check-type-size: boolean, 1
  check-type-size: char, 4
  check-type-size: int, 7
  check-type-size: uint, 7
  check-type-size: float, 7
  check-type-size: int-8, 1
  check-type-size: int-16, 2
  check-type-size: int-32, 4
  check-type-size: int-64, 8
  check-type-size: uint-8, 1
  check-type-size: uint-16, 2
  check-type-size: uint-32, 4
  check-type-size: uint-64, 8
  check-type-size
    array: 15, uint-32
    60
  todo adjust for alignment
  check-type-size
    struct: x int-8, y int-16
    3
  check-type-size
    union: x int-8, y int-16, z int-32
    4
  check-type-size
    bits: x unsigned 1, y signed 14, z boolean
    2

check type-assignable?
  syntax int
  syntax int

check not type-assignable?
  syntax int
  syntax float

check type-assignable?
  syntax int-8
  syntax int-8

check not type-assignable?
  syntax int-8
  syntax int-16

check type-assignable?
  syntax float-32
  syntax float-32

check not type-assignable?
  syntax float-32
  syntax float-64

check not type-assignable?
  syntax int
  syntax int-8

check not type-assignable?
  syntax int
  syntax int-16

check not type-assignable?
  syntax int
  syntax int-32

check not type-assignable?
  syntax int
  syntax int-64

check not type-assignable?
  syntax float
  syntax float-32

check not type-assignable?
  syntax float
  syntax float-64

begin
  comment lambda
  check type-assignable?
    syntax lambda
      with: int, float
      boolean
    syntax lambda
      with: int, float
      boolean

  check not type-assignable?
    syntax lambda
      with: int, float
      boolean
    syntax lambda
      with: int, float, int
      boolean

  check not type-assignable?
    syntax lambda
      with: int, int
      boolean
    syntax lambda
      with: int, float
      boolean

  check not type-assignable?
    syntax lambda
      with: int, float
      boolean
    syntax lambda
      with: int, float
      int
