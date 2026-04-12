library
  leonardo term
  export
    native, native?, native-ref
    native-type, native-type?, native-type-ref
    abstraction, abstraction?, abstraction-procedure
    abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    application, application?, application-target, application-argument
  import mica scheme

  define-data*
    native ref
    native-type ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument

  define-union term
    native
    native-type
    abstraction
    abstraction-type
    application
