library
  mica data syntax
  export
    transform-data
    transform-data-ref
  import
    leo scheme

  define
    field-ref: fields, name
    switch
      assp
        partial: free-identifier=?, name
        map: syntax->list, fields
      when
        _ false?
        syntax-error
          syntax accessor
          `no such field` 'syntax accessor
      else ass syntax-case
        ass
        when
          _ x
          syntax x

  define
    transform-field field
    syntax-case
      field
      when
        name type
        quasisyntax name unsyntax transform-data syntax type

  define
    transform-bit-field bit-field
    syntax-case
      bit-field
      when
        name boolean 1
        free-keyword? boolean
        syntax name unsigned 1
      when
        other
        syntax other

  define
    transform-data data
    syntax-case
      data
      when
        bits: bit-fields, ...
        free-keyword? bits
        quasisyntax bits unsyntax-splicing map
          transform-bit-field
          syntax bit-fields ...
      when
        struct: fields, ...
        free-keyword? struct
        quasisyntax struct unsyntax-splicing map
          transform-field
          syntax fields ...
      when
        other
        syntax other

  define
    transform-data-ref data-ref
    syntax-case
      data-ref
      when
        _: data, expr
        syntax expr
      when
        _
          struct: fields, ...
          expr, accessor, accessors, ...
        free-keyword? struct
        transform-data-ref quasisyntax data-ref
          unsyntax field-ref
            syntax fields ...
            syntax accessor
          ftype-ref
            unsyntax transform-data syntax struct: fields, ...
            expr, accessor
          accessors, ...
      when
        _
          bits: fields, ...
          expr, accessor
        free-keyword? bits
        quasisyntax ftype-ref
          unsyntax transform-data syntax bits: fields, ...
          expr, accessor
