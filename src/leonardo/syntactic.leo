library
  leonardo syntactic
  export
    make-syntactic
    syntactic?
    syntactic-syntax
    syntactic-ref
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
