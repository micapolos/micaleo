import
  mica typed base
  mica typed compile
  mica typed type

define
  compile? stx
  syntax-case
    stx
    keywords: zero?, +, value-a, value-b
    when
      zero?
      syntax :
        lambda
          with: int
          boolean
        zero?
    when
      +
      syntax :
        lambda
          with: int, int
          int
        +
    when
      value-a
      syntax : type-a, value-a
    when
      value-b
      syntax : type-b, value-b
    when
      other
      #f

define-syntax
  when
    check-compiles?: in, type, value
    check equal?
      syntax->datum compile: compile?, syntax in
      ': type, value

define-syntax
  when
    check-compile-error in
    check raises syntax->datum compile: compile?, syntax in

check-compiles?: 123, int, 123
check-compiles?: value-a, type-a, value-a

check-compiles?
  lambda
    with: value-a type-a, value-b type-b
    value-a, value-b
  lambda
    with: type-a, type-b
    type-b
  lambda
    with: value-a, value-b
    value-a, value-b

check-compiles?
  :
    lambda
      with: a1 type-a, a2 type-b
      a1, a2
    value-a, value-b
  type-b
  :
    lambda
      with: a1, a2
      a1, a2
    value-a, value-b

check-compiles?
  let
    with
      a1 value-a
      a2 value-b
    a1, a2
  type-b
  let
    with: a1 value-a, a2 value-b
    a1, a2

check-compiles?
  zero? 123
  boolean
  zero? 123

check-compiles?
  +: 10, 20
  int
  +: 10, 20

begin
  comment if

  check-compiles?
    if: zero? 10, "true", "false"
    string
    if: zero? 10, "true", "false"

  check-compile-error if: 10, "true", "false"
  check-compile-error if: zero? 10, "true", 20
  check-compile-error if: zero? 10, "true"

check-compile-error zero?: value-a
check-compile-error zero?: 10, 20
check-compile-error +: 10, value-a
