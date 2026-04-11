import
  except
    +, zero?
    from mica typed base
  mica typed mico
  mica typed type

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
    with: native-int
    boolean
  inc lambda
    with: native-int
    native-int
  dec lambda
    with: native-int
    native-int
  + lambda
    with: native-int, native-int
    native-int

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
