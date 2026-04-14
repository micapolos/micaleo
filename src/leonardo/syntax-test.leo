import
  mica scheme
  leonardo term
  leonardo datum
  leonardo syntactic
  leonardo syntax

define-syntax rules when
  check-term->syntax: in, out
  check equal?
    syntax->datum term->syntax in
    'out

check-term->syntax
  make-syntactic: syntax fxzero?, make-native 'zero?
  fxzero?

check-term->syntax
  make-application
    make-syntactic syntax foo
    make-syntactic syntax bar
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
