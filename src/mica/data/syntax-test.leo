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
  comment transform-data-op

  check equal?
    syntax->datum transform-data-op syntax ref
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?
    'ftype-ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax * ref
      array
        16
        struct foo bits enabled? boolean
      expr, i, 10, foo, enabled?
    'ftype*-ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, i, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax & ref
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?
    'ftype-&ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax * & ref
      array
        16
        struct foo bits enabled? boolean
      expr, i, 10, foo, enabled?
    'ftype*-&ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, i, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax any ref
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?
    'ftype-any-ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax * any ref
      array
        16
        struct foo bits enabled? boolean
      expr, i, 10, foo, enabled?
    'ftype*-any-ref
      array
        16
        struct foo bits enabled? unsigned 1
      expr, i, 10, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax set!
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?, #t
    'ftype-set!
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?, #t

  check equal?
    syntax->datum transform-data-op syntax * set!
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?, #t
    'ftype*-set!
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?, #t

  check equal?
    syntax->datum transform-data-op syntax any set!
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?, #t
    'ftype-any-set!
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?, #t

  check equal?
    syntax->datum transform-data-op syntax * any set!
      array
        16
        struct foo bits enabled? boolean
      expr, 10, foo, enabled?, #t
    'ftype*-any-set!
      array
        16
        struct foo bits enabled? unsigned 1
      expr, 10, foo, enabled?, #t
