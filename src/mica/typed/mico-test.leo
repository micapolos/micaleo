import
  except
    +, zero?
    from mica typed base
  mica typed mico
  mica typed type

define zero? fxzero?
define add/wrap fx+/wraparound
define sub/wrap fx-/wraparound
define fadd/inexact fl+
define fsub/inexact fl-

define
  inc/wrap int
  add/wrap: int, 1

define
  dec/wrap int
  sub/wrap: int, 1

define-types
  zero? lambda
    with: int
    boolean
  inc/wrap lambda
    with: int
    int
  dec/wrap lambda
    with: int
    int
  add/wrap lambda
    with: int, int
    int
  fadd/inexact lambda
    with: float, float
    float

check equal?: mico #t, #t
check equal?: mico 123, 123
check equal?: mico #\a, #\a
check equal?: mico "foo", "foo"

check equal?: mico zero? 0, #t
check equal?: mico zero? 1, #f

check equal?: mico inc/wrap 1, 2
check equal?: mico dec/wrap 2, 1

check equal?
  mico add/wrap: 10, 20
  30
