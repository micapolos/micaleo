import
  leo scheme
  leonardo term
  leonardo evaluate

define identity lambda: with argument, argument

define
  test-application-resolve application
  make-native application

define
  test-evaluate term
  evaluate: test-application-resolve, term

check raises
  test-evaluate "not term"

check equal?
  test-evaluate make-evaluated "foo"
  make-evaluated "foo"

check equal?
  test-evaluate make-native "foo"
  make-evaluated make-native "foo"

check equal?
  test-evaluate make-abstraction identity
  make-evaluated make-abstraction identity

check equal?
  test-evaluate make-abstraction-type
    make-native "foo"
    identity
  make-evaluated make-abstraction-type
    make-evaluated make-native "foo"
    identity

check equal?
  test-evaluate make-application
    make-abstraction identity
    make-native "foo"
  make-evaluated make-native "foo"

check equal?
  test-evaluate make-application
    make-abstraction-type: make-native "foo", identity
    make-native "foo"
  make-evaluated make-native "foo"

check equal?
  test-evaluate make-application
    make-native zero?
    make-native 123
  make-evaluated make-native make-application
    make-evaluated make-native zero?
    make-evaluated make-native 123
