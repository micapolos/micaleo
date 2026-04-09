import
  except
    +, zero?
    from mica c base
  mica c lang
  mica c keywords

define zero? fxzero?
define + fx+/wraparound

define
  inc fx
  +: fx, 1

define
  dec fx
  -: fx, 1

define-types
  zero? lambda
    with: native overflowing integer
    boolean
  inc lambda
    with: native overflowing integer
    native overflowing integer
  dec lambda
    with: native overflowing integer
    native overflowing integer
  + lambda
    with: native overflowing integer, native overflowing integer
    native overflowing integer

check equal?: lang #t, #t
check equal?: lang 123, 123
check equal?: lang #\a, #\a
check equal?: lang "foo", "foo"

check equal?: lang zero? 0, #t
check equal?: lang zero? 1, #f

check equal?: lang inc 1, 2
check equal?: lang dec 2, 1

check equal?
  lang +: 10, 20
  30
