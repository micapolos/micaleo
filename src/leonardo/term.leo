library
  leonardo term
  export
    make-native, native?, native-ref
    make-abstraction, abstraction?, abstraction-procedure
    make-abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    make-application, application?, application-target, application-argument
    make-variable, variable?, variable-depth
    make-annotated, annotated?, annotated-annotation, annotated-ref
    term-unpeel
  import mica scheme

  comment can we remove: variable, abstraction-type?
  comment it seems that annotated can handle it all

  define-data*
    native ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument
    variable depth
    annotated: annotation, ref

  define
    term-unpeel term
    switch term
      when
        annotated annotated?
        term-unpeel annotated-ref annotated
      else other
        other
