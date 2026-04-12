library
  leonardo evaluate
  export
    evaluated, evaluated?, evaluated-ref
    evaluate
  import
    mica scheme
    leonardo term

  define-data evaluated ref

  define
    evaluate: apply, term
    let
      with evaluate partial: evaluate, apply
      switch
        term
        when
          evaluated evaluated?
          evaluated
        when
          native native?
          evaluated native
        when
          abstraction abstraction?
          evaluated abstraction lambda
            with argument
            evaluate argument
        when
          abstraction-type abstraction-type?
          evaluated abstraction-type
            evaluate abstraction-type-parameter
            lambda
              with argument
              evaluate argument
        when
          application application?
          term-apply
            apply
            evaluate application-target application
            evaluate application-argument application
        else other
          assertion-violation `not term` other

  define
    term-apply: apply, target, argument
    switch
      target
      when
        abstraction abstraction?
        with: abstraction-procedure abstraction, argument
      when
        abstraction-type abstraction-type?
        with: abstraction-type-procedure abstraction, argument
      else other
        evaluated apply: other, argument
