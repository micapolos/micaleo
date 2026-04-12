import
  leo scheme
  mica classifier

define identifier->class make-identifier->class
  number noun
  string noun
  transform verb
  increase verb
  my adjective
  lucky adjective
  now adverb
  later adverb
  slowly adverb
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
  transform verb
  increase verb
  my adjective
  lucky adjective
  now adverb
  later adverb
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
  : transform, verb transform
  : my, adjective my
  : now, adverb now
  : A, label A
  : foo, unclassified foo

  : number x, noun number x
  : string x, noun string x

  : my number, noun my-number
  : my lucky, adjective my-lucky
  : my lucky number, noun my-lucky-number
  : my lucky number n, noun my-lucky-number n

  : number A, noun number-A
  : my number A, noun my-number-A

  : number from string, verb string->number
  : number from string s, verb string->number s

  : slowly later, adverb slowly-later
  : slowly foo, adverb slowly foo

  : transform now, verb transform-now
  : transform slowly later, verb transform-slowly-later

  : transform x, verb transform x
  : transform slowly x, verb transform-slowly x
  : transform slowly string x, verb transform-slowly string x
  : transform slowly my string, verb transform-slowly my-string
  : transform slowly string A, verb transform-slowly string-A

  : is string, verb string?
  : is string s, verb string? s
  : is number my lucky number, verb number? my-lucky-number

  : is number number A, verb number? number-A
  : is string string A, verb string? string-A
  : is string my string A, verb string? my-string-A

  : transform string, verb string-transform
  : transform string s, verb string-transform s
  : transform string my string, verb string-transform my-string
  : increase number my lucky number, verb number-increase my-lucky-number

  : foo bar, unclassified foo bar
