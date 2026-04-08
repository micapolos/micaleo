library
  mica data syntax
  export
    transform-data
    transform-access
    transform-path
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
        syntax-error: name, `no field` name
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
        name boolean
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
        array: size, data
        free-keyword? array
        quasisyntax array
          size
          unsyntax transform-data syntax data
      when
        other
        syntax other

  define
    transform-access access
    syntax-case
      access
      when
        access
          struct: fields, ...
          accessor
        free-keyword? struct
        quasisyntax access
          unsyntax transform-data syntax struct: fields, ...
          unsyntax field-ref
            syntax fields ...
            syntax accessor
      when
        access
          bits: fields, ...
          accessor
        free-keyword? bits
        quasisyntax access unsyntax transform-data syntax bits: fields, ...
      when
        access
          array: size, element-data
          accessor
        free-keyword? array
        quasisyntax access
          unsyntax transform-data syntax array: size, element-data
          element-data

  define
    transform-path path
    syntax-case
      path
      when
        path data
        quasisyntax path unsyntax transform-data syntax data
      when
        path: data, accessor, accessors, ...
        syntax-case
          transform-access syntax access: data, accessor
          when
            access: ftype
            if
              not null? syntax accessors ...
              then
                syntax-error
                  syntax accessors ...
                  'invalid accessors
              else
                syntax path: ftype, accessor
          when
            access: ftype, child-data
            syntax-case
              transform-path syntax path: child-data, accessors, ...
              when
                path: _, accessors, ...
                syntax path: ftype, accessor, accessors, ...

  define
    transform-data-ref data-ref
    syntax-case
      data-ref
      when
        data-ref: data, expr, accessors, ...
        syntax-case
          transform-path syntax path: data, accessors, ...
          when
            path: ftype, accessors, ...
            syntax ftype-ref: ftype, expr, accessors, ...
