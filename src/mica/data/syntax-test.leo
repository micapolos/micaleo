import
  leo scheme
  mica data syntax

begin
  comment transform-data

  check equal?
    syntax->datum transform-data syntax struct: x int, y int
    'struct: x int, y int

  check equal?
    syntax->datum transform-data syntax bits: enabled? boolean, value unsigned 7
    'bits: enabled? unsigned 1, value unsigned 7

  check equal?
    syntax->datum transform-data syntax array: 16, int
    'array: 16, int

  check equal?
    syntax->datum transform-data syntax array
      16
      struct foo bits enabled? boolean
    'array
      16
      struct foo bits enabled? unsigned 1

begin
  comment transform-access

  check equal?
    syntax->datum transform-access syntax access
      struct: x int, y int
      x
    'access
      struct: x int, y int
      int

  check equal?
    syntax->datum transform-access syntax access
      array: 16, int
      10
    'access
      array: 16, int
      int

  check equal?
    syntax->datum transform-access syntax access
      bits: enabled? boolean, value unsigned 7
      enabled?
    'access
      bits: enabled? unsigned 1, value unsigned 7

begin
  comment transform-path

  check equal?
    syntax->datum transform-path syntax path int
    'path int

  check equal?
    syntax->datum transform-path syntax path
      struct: x int, y int
      x
    'path
      struct: x int, y int
      x

  check equal?
    syntax->datum transform-path syntax path
      array
        16
        struct foo bits enabled? boolean
      10, foo, enabled?
    'path
      array
        16
        struct foo bits enabled? unsigned 1
      10, foo, enabled?

begin
  comment transform-data-ref

  check equal?
    syntax->datum transform-data-ref syntax data-ref: foo, bar
    'ftype-ref: foo, bar

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      struct: x int, y int
      expr, x
    'ftype-ref
      struct: x int, y int
      expr, x

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      array: 16, int
      expr, 10
    'ftype-ref
      array: 16, int
      expr, 10

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      array
        16
        array: 32, int
      expr, 10, 12
    'ftype-ref
      array
        16
        array: 32, int
      expr, 10, 12

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      bits: enabled? boolean, value unsigned 7
      expr, enabled?
    'ftype-ref
      bits: enabled? unsigned 1, value unsigned 7
      expr, enabled?

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      struct point struct: x int, y int
      expr, point, y
    'ftype-ref
      struct point struct: x int, y int
      expr, point, y

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?
    'ftype-ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?
