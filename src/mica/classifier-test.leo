import
  leo scheme
  mica classifier

define test-classifier make-classifier
  lambda
    with identifier
    or
      free-identifier=?: identifier, syntax number
      free-identifier=?: identifier, syntax string
  lambda
    with identifier
    or
      free-identifier=?: identifier, syntax append
      free-identifier=?: identifier, syntax downcase
  lambda
    with identifier
    or
      free-identifier=?: identifier, syntax my
      free-identifier=?: identifier, syntax lucky
  lambda
    with identifier
    or
      free-identifier=?: identifier, syntax quickly
  lambda
    with identifier
    or
      free-identifier=?: identifier, syntax A
      free-identifier=?: identifier, syntax B

comment adjective noun
check free-syntax=?
  classifier-transform: test-classifier, syntax my string
  syntax my-string

comment adjective adjective
check free-syntax=?
  classifier-transform: test-classifier, syntax my lucky
  syntax my-lucky

comment adjective ...
check free-syntax=?
  classifier-transform: test-classifier, syntax my foo
  syntax my foo

comment adjective adjective noun
check free-syntax=?
  classifier-transform: test-classifier, syntax my lucky string
  syntax my-lucky-string

comment verb noun
check free-syntax=?
  classifier-transform: test-classifier, syntax append string
  syntax string-append

comment verb noun: arg, ...
check free-syntax=?
  classifier-transform
    test-classifier
    syntax append string: "foo", "bar"
  syntax string-append: "foo", "bar"

comment noun label
check free-syntax=?
  classifier-transform: test-classifier, syntax string A
  syntax string-A

comment noun arg
check free-syntax=?
  classifier-transform: test-classifier, syntax string x
  syntax ensure: string?, x

comment noun from noun
check free-syntax=?
  classifier-transform: test-classifier, syntax number from string
  syntax string->number

comment noun from noun: args, ...
check free-syntax=?
  classifier-transform: test-classifier, syntax number from string x
  syntax string->number x
