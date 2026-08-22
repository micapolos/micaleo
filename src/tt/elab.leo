library
  tt elab
  export
    elab
    elaborate
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
    elaborate: lookup, x
    x lookup
