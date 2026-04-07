import
  leo scheme
  mica data syntax

begin
  comment transform-data

  check equal?
    syntax->datum transform-data syntax struct
      x int
      y int
      flags bits
        enabled? boolean 1
        value unsigned 7
    'struct
      x int
      y int
      flags bits
        enabled? unsigned 1
        value unsigned 7

begin
  comment transform-op

  check equal?
    syntax->datum transform-op syntax ref
      struct: x int, y int
      x
    'ref
      struct: x int, y int
      int

  check equal?
    syntax->datum transform-op syntax ref
      array: 16, int
      10
    'ref
      array: 16, int
      int

  check equal?
    syntax->datum transform-op syntax ref
      bits: enabled? boolean 1, value unsigned 7
      enabled?
    'ref
      bits: enabled? unsigned 1, value unsigned 7
      :

begin
  comment transform-data-ref

  check equal?
    syntax->datum transform-data-ref syntax data-ref: foo, bar
    'bar

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
      array: 32, int
      ftype-ref
        array
          16
          array: 32, int
        expr, 10
      12

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      bits: enabled? boolean 1, value unsigned 7
      expr, enabled?
    'ftype-ref
      bits: enabled? unsigned 1, value unsigned 7
      expr, enabled?

  check equal?
    syntax->datum transform-data-ref syntax data-ref
      struct point struct: x int, y int
      expr, point, y
    'ftype-ref
      struct: x int, y int
      ftype-ref
        struct point struct: x int, y int
        expr, point
      y
