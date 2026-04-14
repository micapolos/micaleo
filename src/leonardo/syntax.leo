library
  leonardo syntax
  export
    term->syntax
    term+syntax
    make-syntax-term
    syntax-term?
    term-syntax
  import
    mica scheme
    leonardo term

  define
    syntax-term? term
    switch? term when
      annotated annotated?
      switch?
        annotated-annotation annotated
        when
          native native?
          syntax? native-ref native

  define
    term-syntax term
    native-ref annotated-annotation term

  define
    term+syntax: term, syntax
    make-annotated
      make-native syntax
      term

  define
    make-syntax-term: syntax
    term+syntax: make-native syntax->datum syntax, syntax

  define
    depth/term->syntax: depth, term
    switch term
      when
        syntax-term syntax-term?
        term-syntax syntax-term
      when
        application application?
        quasisyntax :
          unsyntax depth/term->syntax: depth, application-target application
          unsyntax depth/term->syntax: depth, application-argument application
      when
        abstraction abstraction?
        depth/procedure->syntax: depth, abstraction-procedure abstraction
      else other
        assertion-violation `invalid term` other

  define
    depth/procedure->syntax: depth, procedure
    let*
      with
        symbol string->symbol string-append: "v", number->string depth
        identifier datum->syntax: syntax variable, symbol
        variable make-syntax-term identifier
      quasisyntax lambda
        with unsyntax identifier
        unsyntax depth/term->syntax
          fx+/wraparound: depth, 1
          with: procedure, variable

  define term->syntax partial: depth/term->syntax, 0
