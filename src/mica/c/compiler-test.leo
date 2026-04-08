import
  mica c base
  mica c compiler

define
  typeof identifier
  cond
    when
      free-identifier=?: identifier, syntax fxzero?
      syntax lambda
        with: fixnum
        boolean
    when
      free-identifier=?: identifier, syntax fx+
      syntax lambda
        with: fixnum, fixnum
        fixnum
    when
      free-identifier=?: identifier, syntax v1
      syntax t1
    when
      free-identifier=?: identifier, syntax v2
      syntax t2
    else
      syntax-error: identifier, 'undefined type

check equal?
  syntax->datum compile: typeof, syntax v1
  ': t1, v1

check equal?
  syntax->datum compile: typeof, syntax 123
  ': fixnum, 123

check equal?
  syntax->datum compile
    typeof
    syntax lambda
      with: v1 t1, v2 t2
      v1, v2
  ':
    lambda
      with: t1, t2
      t2
    lambda
      with: v1, v2
      v1, v2

check equal?
  syntax->datum compile
    typeof
    syntax :
      lambda
        with: a1 t1, a2 t2
        a1, a2
      v1, v2
  ':
    t2
    :
      lambda
        with: a1, a2
        a1, a2
      v1, v2

check equal?
  syntax->datum compile
    typeof
    syntax let
      with
        a1 v1
        a2 v2
      a1, a2
  ':
    t2
    let
      with: a1 v1, a2 v2
      a1, a2
