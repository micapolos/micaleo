library
  leonardo evaluated
  export
    evaluated
    evaluated?
    make-evaluated-term
    term-evaluated?
  import
    mica scheme
    leonardo term

  define-data evaluated

  define
    make-evaluated-term term
    make-annotated
      make-native evaluated
      term

  define
    term-evaluated? term
    switch? term when
      annotated annotated?
      switch?
        annotated-annotation annotated
        when
          native native?
          evaluated? native-ref native

