import
  leo scheme
  mica ftype-pointer
  mica editor command

let-ftype
  with
    test-command command-ftype
    expected-command command-ftype
  check equal?
    ftype-pointer->sexpr test-command
    ftype-pointer->sexpr expected-command
