import
  mica c base
  mica c compiler
  mica c keywords

define
  type?-of identifier
  cond
    when
      free-identifier=?: identifier, syntax fxzero?
      syntax lambda
        with: native overflowing integer
        boolean
    when
      free-identifier=?: identifier, syntax fx+
      syntax lambda
        with: native overflowing integer, native overflowing integer
        native overflowing integer
    when
      free-identifier=?: identifier, syntax value-a
      syntax type-a
    when
      free-identifier=?: identifier, syntax value-b
      syntax type-b
    else
      #f

check equal?
  syntax->datum compile
    type?-of
    syntax compiled: native int, 123
  ': native int, 123

check equal?
  syntax->datum compile: type?-of, syntax value-a
  'type-a value-a

check equal?
  syntax->datum compile
    type?-of
    syntax compiled: fixnum, 123
  'fixnum 123

check equal?
  syntax->datum compile
    type?-of
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
    type?-of
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
    type?-of
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
    type?-of
    syntax fxzero? compiled: native overflowing integer, 123
  'boolean fxzero? 123

check equal?
  syntax->datum compile
    type?-of
    syntax fx+
      compiled: native overflowing integer, 10
      compiled: native overflowing integer, 20
  ':
    native overflowing integer
    fx+: 10, 20

check raises compile
  type?-of
  syntax fxzero?: value-a

check raises compile
  type?-of
  syntax fxzero?: 10, 20

check raises compile
  type?-of
  syntax fx+: 10, value-a
