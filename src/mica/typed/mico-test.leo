import
  except
    +, zero?
    from mica typed base
  mica typed mico
  mica typed keywords

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

check equal?: mico #t, #t
check equal?: mico 123, 123
check equal?: mico #\a, #\a
check equal?: mico "foo", "foo"

check equal?: mico zero? 0, #t
check equal?: mico zero? 1, #f

check equal?: mico inc 1, 2
check equal?: mico dec 2, 1

check equal?
  mico +: 10, 20
  30
