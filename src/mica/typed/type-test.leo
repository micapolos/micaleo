import
  mica typed base
  mica typed type

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
