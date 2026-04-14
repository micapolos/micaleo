library
  leonardo syntax
  export term->syntax
  import
    mica scheme
    leonardo term
    leonardo syntactic

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
      symbol string->symbol string-append: "v", number->string depth
      identifier datum->syntax: syntax variable, symbol
      variable make-native-syntactic identifier
      in quasisyntax lambda
        with unsyntax identifier
        unsyntax depth/term->syntax
          fx+/wraparound: depth, 1
          with: procedure, variable

  define term->syntax partial: depth/term->syntax, 0
