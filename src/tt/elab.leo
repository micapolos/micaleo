library
  tt elab
  export
    elab
    run-elab
    check-elab
  import
    leo scheme
    tt lookup

  define-syntax rules
    when
      elab x
      lambda
        with lookup
        values: lookup, x
    when
      elab: id expr, param, ..., x
      lambda
        with lookup
        values
          lookup-push: lookup, syntax id, expr
          elab: param, ..., x

  define
    run-elab: lookup, x
    x lookup

  define-syntax
    keywords when
    rules when
      check-elab
        when: id var, ..., elab
        id2 var2, ..., out
      let-values
        with
          values: lookup, x
          run-elab
            lookup: id var, ...
            elab
        in
          check-lookup: lookup, id2 var2, ...
          check equal?: x, out
