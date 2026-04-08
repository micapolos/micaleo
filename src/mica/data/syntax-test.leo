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
      struct foo bits enabled? boolean
      x, foo, enabled?
    'ftype-ref
      struct foo bits enabled? unsigned 1
      x, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax *-ref
      struct foo bits enabled? boolean
      x, i, foo, enabled?
    'ftype*-ref
      struct foo bits enabled? unsigned 1
      x, i, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax &ref
      struct foo bits enabled? boolean
      x, foo, enabled?
    'ftype-&ref
      struct foo bits enabled? unsigned 1
      x, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax *-&ref
      struct foo bits enabled? boolean
      x, i, foo, enabled?
    'ftype*-&ref
      struct foo bits enabled? unsigned 1
      x, i, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax any-ref
      struct foo bits enabled? boolean
      x, foo, enabled?
    'ftype-any-ref
      struct foo bits enabled? unsigned 1
      x, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax *-any-ref
      struct foo bits enabled? boolean
      x, i, foo, enabled?
    'ftype*-any-ref
      struct foo bits enabled? unsigned 1
      x, i, foo, enabled?

  check equal?
    syntax->datum transform-data-op syntax set!
      struct foo bits enabled? boolean
      x, foo, enabled?, v
    'ftype-set!
      struct foo bits enabled? unsigned 1
      x, foo, enabled?, v

  check equal?
    syntax->datum transform-data-op syntax *-set!
      struct foo bits enabled? boolean
      x, i, foo, enabled?, v
    'ftype*-set!
      struct foo bits enabled? unsigned 1
      x, i, foo, enabled?, v

  check equal?
    syntax->datum transform-data-op syntax any-set!
      struct foo bits enabled? boolean
      x, foo, enabled?, v
    'ftype-any-set!
      struct foo bits enabled? unsigned 1
      x, foo, enabled?, v

  check equal?
    syntax->datum transform-data-op syntax *-any-set!
      struct foo bits enabled? boolean
      x, i, foo, enabled?, v
    'ftype*-any-set!
      struct foo bits enabled? unsigned 1
      x, i, foo, enabled?, v

check equal?
  syntax->datum transform-define-syntax-data-op: syntax point, syntax ref
  'define-syntax
    when
      point-ref: x, ...
      ftype-ref: point, x, ...

check equal?
  syntax->datum transform-define-syntax-data-clear!: syntax point
  'define-syntax
    when
      point-clear! x
      ftype-clear!: point, x

check equal?
  syntax->datum transform-define-syntax-data-fill!: syntax point
  'define-syntax
    when
      point-fill!: x, v
      ftype-fill!: point, x, v
