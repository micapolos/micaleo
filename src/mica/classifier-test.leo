import
  leo scheme
  mica classifier

define identifier->class make-identifier->class
  number noun
  string noun
  append verb
  my adjective
  lucky adjective
  quickly adverb
  A label
  B label

define-syntax rules when
  check-classes: x class, ...
  begin
    check equal?
      syntax->datum identifier->class syntax x
      'class
    ...

check-classes
  number noun
  string noun
  append verb
  my adjective
  lucky adjective
  quickly adverb
  A label
  B label
  foo unclassified

define-syntax rules when
  check-classify
    : in, out
    ...
  begin
    check equal?
      syntax->datum classify: identifier->class, syntax in
      'out
    ...

check-classify
  : number, noun number
  : append, verb append
  : my, adjective my
  : quickly, adverb quickly
  : A, label A

  : number x, noun number x
  : string x, noun string x

  : my number, noun my-number
  : my lucky, adjective my-lucky
  : my lucky number, noun my-lucky-number

  : number A, noun number-A
  : my number A, noun my-number-A

  : number from string, noun string->number
  : number from string x, noun string->number x

  : is string, noun string?
  : is string x, noun string? x
  : is my string x, noun my-string? x
  : is my lucky number x, noun my-lucky-number? x

  : foo bar, unclassified foo bar
