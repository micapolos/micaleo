library
  mica data syntax
  export
    transform-data
    transform-access
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
    transform-access op
    syntax-case
      op
      when
        op
          struct: fields, ...
          accessor
        free-keyword? struct
        quasisyntax op
          unsyntax transform-data syntax struct: fields, ...
          unsyntax field-ref
            syntax fields ...
            syntax accessor
      when
        op
          bits: fields, ...
          accessor
        free-keyword? bits
        quasisyntax op unsyntax transform-data syntax bits: fields, ...
      when
        op
          array: size, element-data
          accessor
        free-keyword? array
        quasisyntax op
          unsyntax transform-data syntax array: size, element-data
          element-data

  define
    transform-data-ref data-ref
    syntax-case
      data-ref
      when
        data-ref: data, expr
        syntax expr
      when
        data-ref: data, expr, accessor, accessors, ...
        syntax-case
          transform-access syntax op: data, accessor
          when
            op: ftype
            if
              not null? syntax accessors ...
              then
                syntax-error
                  syntax accessors ...
                  'invalid accessors
              else quasisyntax ftype-ref
                unsyntax transform-data syntax data
                expr, accessor
          when
            op: ftype, child-data
            transform-data-ref quasisyntax data-ref
              child-data
              ftype-ref
                unsyntax transform-data syntax data
                expr, accessor
              accessors, ...
