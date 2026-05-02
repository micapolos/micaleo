library
  leonardo equal
  export
    term=?
    check-term=?
  import
    mica scheme
    leonardo term
    leonardo datum

  define
    term=?: term-a, term-b
    equal?
      term->datum term-a
      term->datum term-b

  define-syntax rules when
    check-term=?: a, b
    let*-values
      with
        values: procedure, datum, sources
        sourced a
      with
        values: term-datum, expected-datum
        values
          guard
            else exception
              assertion-violation 'check-term=?
                unquote-splicing sources
                expression' datum
                raised' exception
            in term->datum with procedure
          'b
      in unless
        equal?: term-datum, expected-datum
        assertion-violation 'check-term=?
          unquote-splicing sources
          expression' datum
          expected' expected-datum
          actual' term-datum
