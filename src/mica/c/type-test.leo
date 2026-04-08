import
  leo scheme
  mica c type
  mica c keywords

begin
  comment identifier
  check type-assignable?
    syntax int
    syntax int

  check not type-assignable?
    syntax int
    syntax float

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
