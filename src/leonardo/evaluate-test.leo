import
  leo scheme
  leonardo term
  leonardo evaluate
  leonardo datum

define
  test-application-resolve application
  make-native `resolved` term->datum application

define
  test-evaluate term
  evaluate: test-application-resolve, term

check raises
  test-evaluate "not term"

check equal?
  term->datum test-evaluate make-evaluated make-native "foo"
  'evaluated native "foo"

check equal?
  term->datum test-evaluate make-native "foo"
  'evaluated native "foo"

check equal?
  term->datum test-evaluate make-native zero?
  `evaluated native` zero?

check equal?
  term->datum test-evaluate make-abstraction lambda: with argument, argument
  'evaluated abstraction lambda: with variable 0, evaluated variable 0

check equal?
  term->datum test-evaluate make-abstraction-type
    make-native "foo"
    lambda: with argument, argument
  'evaluated abstraction-type
    evaluated native "foo"
    lambda: with variable 0, evaluated variable 0

check equal?
  term->datum test-evaluate make-application
    make-abstraction lambda: with argument, argument
    make-native "foo"
  'evaluated native "foo"

check equal?
  term->datum test-evaluate make-application
    make-abstraction-type
      make-native "foo"
      lambda: with argument, argument
    make-native "foo"
  'evaluated native "foo"

check equal?
  term->datum test-evaluate make-application
    make-native 'fn
    make-native 'arg
  'evaluated native resolved application
    evaluated native fn
    evaluated native arg

check equal?
  term->datum test-evaluate make-abstraction lambda
    with argument
    make-application
      make-native 'fn
      argument
  'evaluated abstraction lambda
    with variable 0
    evaluated native resolved application
      evaluated native fn
      evaluated variable 0

check equal?
  term->datum test-evaluate make-abstraction-type
    make-native 'string
    lambda
      with argument
      make-application
        make-native 'fn
        argument
  'evaluated abstraction-type
    evaluated native string
    lambda
      with variable 0
      evaluated native resolved application
        evaluated native fn
        evaluated variable 0
