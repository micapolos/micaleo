import
  mica c base
  mica c compiler

define
  typeof identifier
  identifier-append: identifier, identifier, syntax -, syntax type

check equal?
  syntax->datum compile: typeof, syntax point
  'compiled: point-type, point

check equal?
  syntax->datum compile: typeof, syntax 123
  'compiled: fixnum, 123
