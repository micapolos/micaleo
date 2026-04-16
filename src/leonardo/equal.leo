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
    check-term=?: actual, expected
    let*-values
      with
        values: term, source, path?, line?, column?
        sourced actual
      with
        values: term-datum, expected-datum
        values: term->datum actual, 'expected
      in unless
        equal?: term-datum, expected-datum
        if
          and: path?, line?, column?
          then assertion-violation `check
            in` path?
            at: line` line?, column` column?
            expression` source
            expected` expected-datum
            actual` term-datum
          else assertion-violation `check
            expression` source
            expected` expected-datum
            actual` term-datum
