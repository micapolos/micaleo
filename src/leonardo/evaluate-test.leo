import
  leo scheme
  leonardo term
  leonardo evaluate

check raises
  evaluate "not term"

check equal?
  evaluate native "foo"
  evaluated native "foo"
