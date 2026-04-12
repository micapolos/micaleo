library
  leonardo evaluate
  export evaluate
  import
    mica scheme
    leonardo term

  define-data evaluated ref

  define
    evaluate term
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
        evaluated with
          evaluate application-target application
          evaluate application-argument application
      else other
        error: 'evaluate, "not term", other



