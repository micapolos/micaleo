import
  mica c base
  mica c compiler

define
  compile? stx
  syntax-case
    stx
    keywords: zero?, +, value-a, value-b
    when
      s
      string? datum s
      syntax : string, s
    when
      n
      number? datum n
      syntax : number, n
    when
      zero?
      syntax :
        lambda
          with: number
          boolean
        zero?
    when
      +
      syntax :
        lambda
          with: number, number
          number
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

check equal?
  syntax->datum compile
    compile?
    syntax 123
  ': number, 123

check equal?
  syntax->datum compile: compile?, syntax value-a
  'type-a value-a

check equal?
  syntax->datum compile
    compile?
    syntax lambda
      with: value-a type-a, value-b type-b
      value-a, value-b
  ':
    lambda
      with: type-a, type-b
      type-b
    lambda
      with: value-a, value-b
      value-a, value-b

check equal?
  syntax->datum compile
    compile?
    syntax :
      lambda
        with: a1 type-a, a2 type-b
        a1, a2
      value-a, value-b
  'type-b :
    lambda
      with: a1, a2
      a1, a2
    value-a, value-b

check equal?
  syntax->datum compile
    compile?
    syntax let
      with
        a1 value-a
        a2 value-b
      a1, a2
  'type-b let
    with: a1 value-a, a2 value-b
    a1, a2

check equal?
  syntax->datum compile
    compile?
    syntax zero? 123
  'boolean zero? 123

check equal?
  syntax->datum compile
    compile?
    syntax +: 10, 20
  ':
    number
    +: 10, 20

begin
  comment if

  check equal?
    syntax->datum compile
      compile?
      syntax if: zero? 10, "true", "false"
    ':
      string
      if: zero? 10, "true", "false"

  check raises compile
    compile?
    syntax if: 10, "true", "false"

  check raises compile
    compile?
    syntax if: zero? 10, "true", 20

  check raises compile
    compile?
    syntax if: zero? 10, "true"

check raises compile
  compile?
  syntax zero?: value-a

check raises compile
  compile?
  syntax zero?: 10, 20

check raises compile
  compile?
  syntax +: 10, value-a
