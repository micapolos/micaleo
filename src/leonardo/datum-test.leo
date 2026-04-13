import
  leo scheme
  leonardo term
  leonardo datum

check equal?
  term->datum make-native zero?
  `native` zero?

check equal?
  term->datum make-variable 10
  'variable 10

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
  'abstraction lambda
    with variable 0
    application: variable 0, variable 0

check equal?
  term->datum make-abstraction-type
    make-native "string"
    lambda
      with argument
      make-application: argument, argument
  'abstraction-type
    native "string"
    lambda
      with variable 0
      application: variable 0, variable 0

check equal?
  term->datum make-evaluated make-native 10
  'evaluated native 10
