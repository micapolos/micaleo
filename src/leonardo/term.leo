library
  leonardo term
  export
    make-native, native?, native-ref
    make-abstraction, abstraction?, abstraction-procedure
    make-abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    make-application, application?, application-target, application-argument
    make-evaluated, evaluated?, evaluated-ref
    make-variable, variable?, variable-depth
  import mica scheme

  define-data*
    native ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument
    evaluated ref
    variable depth
