import
  leo scheme
  leonardo term
  leonardo evaluate

define
  test-apply: target, argument
  cond
    when
      and
        equal?: target, evaluated native number->string
        evaluated? argument
        native? evaluated-ref argument
      native number->string native-ref evaluated-ref argument
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
