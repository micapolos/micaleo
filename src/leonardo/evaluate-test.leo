import
  leo scheme
  leonardo term
  leonardo evaluate

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

begin
  comment application-native-refs?

  check equal?
    application-native-refs? application
      evaluated native zero?
      evaluated native 123
    list: zero?, 123

  check equal?
    application-native-refs? application
      evaluated application
        evaluated native string-append
        evaluated native "foo"
      evaluated native "bar"
    list: string-append, "foo", "bar"

begin
  comment application-resolve

  define
    test-application-resolve application
    application-resolve: arity-of, application

  check equal?
    test-application-resolve application
      evaluated native number->string
      evaluated native 123
    native "123"

  check equal?
    test-application-resolve application
      evaluated application
        evaluated native string-append
        evaluated native "foo"
      evaluated native "bar"
    native "foobar"

begin
  comment evaluate

  define
    test-evaluate term
    evaluate: arity-of, term

  check raises
    test-evaluate "not term"

  check equal?
    test-evaluate evaluated "foo"
    evaluated "foo"

  check equal?
    test-evaluate native "foo"
    evaluated native "foo"

  check equal?
    test-evaluate application
      native zero?
      native 123
    evaluated application
      evaluated native zero?
      evaluated native 123

  check equal?
    test-evaluate application
      native number->string
      native 123
    evaluated native "123"

  check equal?
    test-evaluate application
      native string-append
      native "foo"
    evaluated application
      evaluated native string-append
      evaluated native "foo"

  check equal?
    test-evaluate application
      application
        native string-append
        native "foo"
      native "bar"
    evaluated native "foobar"
