library
  leonardo evaluate
  export
    evaluate
  import
    mica scheme
    leonardo term

  define
    evaluate: resolve, term
    switch term
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
          resolve
          abstraction-procedure abstraction
      when
        abstraction-type abstraction-type?
        make-evaluated make-abstraction-type
          evaluate: resolve, abstraction-type-parameter abstraction-type
          evaluate-procedure: resolve, abstraction-type-procedure abstraction-type
      when
        application application?
        evaluate
          resolve
          term-apply
            resolve
            evaluate: resolve, application-target application
            evaluate: resolve, application-argument application
      when
        annotated annotated?
        make-evaluated make-annotated
          evaluate: resolve, annotated-annotation annotated
          evaluate: resolve, annotated-ref annotated
      else other
        assertion-violation `not term` other

  define
    evaluate-procedure: resolve, procedure
    lambda
      with argument
      evaluate
        resolve
        with: procedure, argument

  define
    term-apply: resolve, target, argument
    switch
      term-unpeel target
      when
        abstraction abstraction?
        with: abstraction-procedure abstraction, argument
      when
        abstraction-type abstraction-type?
        with: abstraction-type-procedure abstraction-type, argument
      else _
        resolve make-application: target, argument
