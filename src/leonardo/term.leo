library
  leonardo term
  export
    native, native?, native-ref
    abstraction, abstraction?, abstraction-procedure
    abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    application, application?, application-target, application-argument
    evaluated, evaluated?, evaluated-ref
  import mica scheme

  define-data*
    native ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument
    evaluated ref
