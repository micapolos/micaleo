library
  leonardo syntactic
  export
    make-syntactic
    syntactic?
    syntactic-syntax
    syntactic-ref
    term->syntax
  import
    mica scheme
    leonardo term

  define
    syntactic? term
    switch? term when
      annotated annotated?
      switch?
        annotated-annotation annotated
        when
          native native?
          syntax? native-ref native

  define
    syntactic-syntax term
    native-ref annotated-annotation term

  define
    syntactic-ref term
    native-ref annotated-ref term

  define make-syntactic case-lambda
    :
      : syntax, term
      make-annotated
        make-native syntax
        term
    :
      : syntax
      make-syntactic
        syntax
        make-native syntax->datum syntax

  define
    depth/term->syntax: depth, term
    switch term
      when
        syntax-term syntactic?
        syntactic-syntax syntax-term
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
        variable make-syntactic identifier
      quasisyntax lambda
        with unsyntax identifier
        unsyntax depth/term->syntax
          fx+/wraparound: depth, 1
          with: procedure, variable

  define term->syntax partial: depth/term->syntax, 0
