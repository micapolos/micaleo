import
  mica c base
  mica c compiler
  mica c keywords

define
  compile? stx
  syntax-case
    stx
    keywords: number, zero?, +, value-a, value-b
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

check raises compile
  compile?
  syntax fxzero?: value-a

check raises compile
  compile?
  syntax fxzero?: 10, 20

check raises compile
  compile?
  syntax fx+: 10, value-a
