import
  mica scheme
  leonardo term
  leonardo datum
  leonardo syntax

check syntax-term? make-annotated
  make-native syntax foo
  make-native 123

check free-syntax=?
  term-syntax make-annotated
    make-native syntax foo
    make-native 123
  syntax foo

check free-syntax=?
  term-syntax make-syntax-term syntax foo
  syntax foo

define-syntax rules when
  check-term->syntax: in, out
  check equal?
    syntax->datum term->syntax in
    'out

check-term->syntax
  term+syntax: make-native 'zero?, syntax fxzero?
  fxzero?

check-term->syntax
  make-application
    make-syntax-term syntax foo
    make-syntax-term syntax bar
  foo bar

check-term->syntax
  make-abstraction lambda
    with argument
    make-application: argument, argument
  lambda: with v0, v0 v0

check-term->syntax
  make-abstraction lambda
    with argument-1
    make-abstraction lambda
      with argument-2
      make-application: argument-1, argument-2
  lambda
    with v0
    lambda
      with v1
      v0 v1
