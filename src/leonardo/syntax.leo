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
        with-identifier
          target depth/term->syntax: depth, application-target application
          argument depth/term->syntax: depth, application-argument application
          in syntax : target, argument
      when
        abstraction abstraction?
        depth/procedure->syntax: depth, abstraction-procedure abstraction
      else other
        assertion-violation `invalid term` other

  define
    depth/procedure->syntax: depth, procedure
    with-identifier*
      identifier datum->syntax
        syntax variable
        string->symbol string-append: "v", number->string depth
      body depth/term->syntax
        fx+/wraparound: depth, 1
        with: procedure, make-native-syntactic syntax identifier
      in syntax lambda: with identifier, body

  define term->syntax partial: depth/term->syntax, 0
