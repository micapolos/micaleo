library
  mica qualified
  export
    qualified
  import
    leo scheme
    mica qualifier

  define-syntax
    qualified stx
    lambda
      with lookup?
      syntax-case
        stx
        when
          qualified id1 id2
          and
            identifier? syntax id1
            identifier? syntax id2
          identifier-append: syntax id1, syntax id1, syntax -, syntax id2
        when
          qualified id1 id2: xs, ...
          and
            identifier? syntax id1
            identifier? syntax id2
          let
            with qualified-syntax quasisyntax :
              unsyntax identifier-append: syntax id1, syntax id1, syntax -, syntax id2
              xs, ...
            if
              lookup?: syntax id2, syntax qualifier?
              then quasisyntax qualified unsyntax qualified-syntax
              else qualified-syntax
        when
          qualified: xs, ...
          syntax xs ...
