library
  leonardo evaluate
  export
    evaluated, evaluated?, evaluated-ref
    evaluate
    application-native-refs?
  import
    mica scheme
    leonardo term

  define-data evaluated ref

  define
    cons-application-native-refs?: application, native-refs
    and
      evaluated? application-argument application
      native? evaluated-ref application-argument application
      evaluated? application-target application
      let
        with native-refs cons
          native-ref evaluated-ref application-argument application
          native-refs
        cond
          when
            native? evaluated-ref application-target application
            cons
              native-ref evaluated-ref application-target application
              native-refs
          when
            application? evaluated-ref application-target application
            cons-application-native-refs?
              evaluated-ref application-target application
              native-refs
          else #f

  define
    application-native-refs? application
    cons-application-native-refs?: application, null

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
