library
  leonardo evaluate
  export
    evaluate
  import
    mica scheme
    leonardo term

  define
    evaluate: application-resolve, term
    let
      with evaluate partial: evaluate, application-resolve
      switch
        term
        when
          evaluated evaluated?
          evaluated
        when
          native native?
          make-evaluated native
        when
          abstraction abstraction?
          make-evaluated abstraction
        when
          abstraction-type abstraction-type?
          make-evaluated make-abstraction-type
            evaluate abstraction-type-parameter abstraction-type
            abstraction-type-procedure abstraction-type
        when
          application application?
          evaluate term-apply
            application-resolve
            evaluate application-target application
            evaluate application-argument application
        else other
          assertion-violation `not term` other

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
