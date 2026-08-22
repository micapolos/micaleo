library
  tt lookup
  export
    empty-lookup
    lookup-push
    lookup
    check-lookup
  import
    leo scheme

  define empty-lookup
    lambda
      with identifier
      syntax-error identifier

  define
    lookup-push: lookup, identifier, value
    lambda
      with lookup-identifier
      if
        free-identifier=?: lookup-identifier, identifier
        value
        lookup lookup-identifier

  define-syntax rules
    when
      lookup:
      empty-lookup
    when
      lookup: id x, rest, ...
      lookup-push
        lookup: rest, ...
        syntax id
        x

  define-syntax rules
    when
      check-lookup: lookup, id x, ...
      begin
        check equal?: lookup syntax id, x
        ...
