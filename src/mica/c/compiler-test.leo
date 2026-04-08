import
  mica c base
  mica c compiler

define
  typeof identifier
  identifier-append: identifier, identifier, syntax -, syntax type

check equal?
  syntax->datum compile: typeof, syntax point
  ': point-type, point

check equal?
  syntax->datum compile: typeof, syntax 123
  ': fixnum, 123

check equal?
  syntax->datum compile
    typeof
    syntax let
      with
        v1 t1
        v2 t2
      v1, v2
  ':
    t2-type
    let
      with: v1 t1, v2 t2
      v1, v2
