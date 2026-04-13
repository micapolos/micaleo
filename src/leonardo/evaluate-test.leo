import
  leo scheme
  leonardo term
  leonardo evaluated
  leonardo evaluate
  leonardo datum

define
  test-resolve application
  make-native `resolved` application

define
  test-evaluate term
  evaluate: test-resolve, term

define-syntax rules when
  check-evaluates: in, out
  check equal?
    term->datum test-evaluate in
    term->datum out

check raises
  test-evaluate "not term"

check-evaluates
  make-evaluated-term make-native "foo"
  make-annotated
    make-native evaluated
    make-native "foo"

check-evaluates
  make-native "foo"
  make-evaluated-term make-native "foo"

check-evaluates
  make-native zero?
  make-evaluated-term make-native zero?

check-evaluates
  make-abstraction lambda: with argument, argument
  make-evaluated-term make-abstraction lambda
    with argument
    make-evaluated-term argument

check-evaluates
  make-abstraction-type
    make-native "foo"
    lambda: with argument, argument
  make-evaluated-term make-abstraction-type
    make-evaluated-term make-native "foo"
    lambda: with argument, make-evaluated-term argument

check-evaluates
  make-application
    make-abstraction lambda: with argument, argument
    make-native "foo"
  make-evaluated-term make-native "foo"

check-evaluates
  make-application
    make-abstraction-type
      make-native "foo"
      lambda: with argument, argument
    make-native "foo"
  make-evaluated-term make-native "foo"

check-evaluates
  make-annotated
    make-native "annotation"
    make-native "term"
  make-evaluated-term make-annotated
    make-evaluated-term make-native "annotation"
    make-evaluated-term make-native "term"

check-evaluates
  make-application
    make-native 10
    make-native 20
  make-evaluated-term make-native `resolved` make-application
    make-evaluated-term make-native 10
    make-evaluated-term make-native 20

check-evaluates
  make-application
    make-application
      make-abstraction lambda
        with argument-a
        make-abstraction lambda
          with argument-b
          make-application: argument-a, argument-b
      make-native "foo"
    make-native "bar"
  make-evaluated-term make-native `resolved` make-application
    make-evaluated-term make-native "foo"
    make-evaluated-term make-native "bar"

check-evaluates
  make-abstraction lambda
    with argument
    make-application
      make-native 'fn
      argument
  make-evaluated-term make-abstraction lambda
    with argument
    make-evaluated-term make-native `resolved` make-application
      make-evaluated-term make-native 'fn
      make-evaluated-term argument

check-evaluates
  make-abstraction-type
    make-native 'string
    lambda
      with argument
      make-application
        make-native 'fn
        argument
  make-evaluated-term make-abstraction-type
    make-evaluated-term make-native 'string
    lambda
      with argument
      make-evaluated-term make-native `resolved` make-application
        make-evaluated-term make-native 'fn
        make-evaluated-term argument
