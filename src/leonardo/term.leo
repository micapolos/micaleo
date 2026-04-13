library
  leonardo term
  export
    rename native make-native, native?, native-ref
    rename abstraction make-abstraction, abstraction?, abstraction-procedure
    rename abstraction-type make-abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    rename application make-application, application?, application-target, application-argument
    rename evaluated make-evaluated, evaluated?, evaluated-ref
  import mica scheme

  define-data*
    native ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument
    evaluated ref
