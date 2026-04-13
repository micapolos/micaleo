import
  leo scheme
  leonardo term
  leonardo resolve

check equal?
  application-native-refs? make-application
    make-evaluated make-native zero?
    make-evaluated make-native 123
  list: zero?, 123

check equal?
  application-native-refs? make-application
    make-evaluated make-application
      make-evaluated make-native string-append
      make-evaluated make-native "foo"
    make-evaluated make-native "bar"
  list: string-append, "foo", "bar"

define
  arity-of x
  cond
    when
      equal?: x, number->string
      1
    when
      equal?: x, string-append
      2
    else 0

define
  test-application-resolve application
  application-resolve: arity-of, application

check equal?
  test-application-resolve make-application
    make-evaluated make-native number->string
    make-evaluated make-native 123
  make-native "123"

check equal?
  test-application-resolve make-application
    make-evaluated make-application
      make-evaluated make-native string-append
      make-evaluated make-native "foo"
    make-evaluated make-native "bar"
  make-native "foobar"
