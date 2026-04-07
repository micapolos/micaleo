import
  leo scheme
  mica data syntax

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
    struct point struct: x int, y int
    expr, point, y
  'ftype-ref
    struct: x int, y int
    ftype-ref
      struct point struct: x int, y int
      expr, point
    y

check equal?
  syntax->datum transform-data-ref syntax data-ref
    bits: enabled? boolean 1, value unsigned 7
    expr, enabled?
  'ftype-ref
    bits: enabled? unsigned 1, value unsigned 7
    expr, enabled?
