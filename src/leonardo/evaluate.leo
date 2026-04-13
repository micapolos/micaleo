library
  leonardo evaluate
  export
    evaluate
  import
    mica scheme
    leonardo term

  define
    evaluate: application-resolve, term
    switch
      term
      when
        evaluated evaluated?
        evaluated
      when
        native native?
        make-evaluated native
      when
        variable variable?
        make-evaluated variable
      when
        abstraction abstraction?
        make-evaluated make-abstraction evaluate-procedure
          application-resolve
          abstraction-procedure abstraction
      when
        abstraction-type abstraction-type?
        make-evaluated make-abstraction-type
          evaluate: application-resolve, abstraction-type-parameter abstraction-type
          evaluate-procedure: application-resolve, abstraction-type-procedure abstraction-type
      when
        application application?
        evaluate
          application-resolve
          term-apply
            application-resolve
            evaluate: application-resolve, application-target application
            evaluate: application-resolve, application-argument application
      when
        annotated annotated?
        make-evaluated make-annotated
          evaluate: application-resolve, annotated-annotation annotated
          evaluate: application-resolve, annotated-ref annotated
      else other
        assertion-violation `not term` other

  define
    evaluate-procedure: application-resolve, procedure
    lambda
      with argument
      evaluate
        application-resolve
        with: procedure, argument

  define
    term-apply: application-resolve, target, argument
    switch
      target
      when
        evaluated evaluated?
        switch
          evaluated-ref evaluated
          when
            abstraction abstraction?
            with: abstraction-procedure abstraction, argument
          when
            abstraction-type abstraction-type?
            with: abstraction-type-procedure abstraction-type, argument
          else _
            application-resolve make-application: target, argument
      else _
        application-resolve make-application: target, argument
