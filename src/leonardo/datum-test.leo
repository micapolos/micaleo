import
  leo scheme
  leonardo term
  leonardo datum

check equal?
  term->datum make-native zero?
  `native` zero?

check equal?
  term->datum make-application
    make-native 10
    make-native 20
  'application
    native 10
    native 20

check equal?
  term->datum make-abstraction lambda
    with argument
    make-application: argument, argument
  'abstraction application: variable 0, variable 0

check equal?
  term->datum make-abstraction lambda
    with argument-a
    make-abstraction lambda
      with argument-b
      make-application: argument-a, argument-b
  'abstraction abstraction application: variable 1, variable 0

check equal?
  term->datum make-abstraction-type
    make-native "string"
    lambda
      with argument
      make-application: argument, argument
  'abstraction-type
    native "string"
    application: variable 0, variable 0

check equal?
  term->datum make-annotated
    make-native "annotation"
    make-native "term"
  'annotated
    native "annotation"
    native "term"
