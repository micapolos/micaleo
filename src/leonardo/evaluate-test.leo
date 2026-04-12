import
  leo scheme
  leonardo term
  leonardo evaluate

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

comment extract detection of native application with given arity
define
  test-apply: target, argument
  cond
    when
      and
        equal?: target, evaluated native number->string
        evaluated? argument
        native? evaluated-ref argument
      native number->string native-ref evaluated-ref argument
    when
      and
        evaluated? target
        application? evaluated-ref target
        evaluated application-target evaluated-ref target
        native? evaluated-ref application-target evaluated-ref target
        eq?: string-append, native-ref evaluated-ref application-target evaluated-ref target
        evaluated application-argument evaluated-ref target
        native? evaluated-ref application-argument evaluated-ref target
        evaluated? argument
        native? evaluated-ref argument
      native string-append
        native-ref evaluated-ref application-argument evaluated-ref target
        native-ref evaluated-ref argument
    else
      application: target, argument

define
  test-evaluate term
  evaluate: test-apply, term

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
