library
  mica data syntax
  export
    transform-data
    transform-data-op
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

  define-keywords: ref, any, &

  define
    transform-data-op op
    syntax-case
      op
      when
        ref: data, expr, accessors, ...
        free-keyword? ref
        quasisyntax ftype-ref
          unsyntax transform-data syntax data
          expr, accessors, ...
      when
        *-ref: data, expr, index, accessors, ...
        free-keyword? *-ref
        quasisyntax ftype*-ref
          unsyntax transform-data syntax data
          expr, index, accessors, ...
      when
        &ref: data, expr, accessors, ...
        free-keyword? &ref
        quasisyntax ftype-&ref
          unsyntax transform-data syntax data
          expr, accessors, ...
      when
        *-&ref: data, expr, index, accessors, ...
        free-keyword? *-&ref
        quasisyntax ftype*-&ref
          unsyntax transform-data syntax data
          expr, index, accessors, ...
      when
        any-ref: data, expr, accessors, ...
        free-keyword? any-ref
        quasisyntax ftype-any-ref
          unsyntax transform-data syntax data
          expr, accessors, ...
      when
        *-any-ref: data, expr, index, accessors, ...
        free-keyword? *-any-ref
        quasisyntax ftype*-any-ref
          unsyntax transform-data syntax data
          expr, index, accessors, ...
      when
        set!: data, expr, accessors, ..., v
        free-keyword? set!
        quasisyntax ftype-set!
          unsyntax transform-data syntax data
          expr, accessors, ..., v
      when
        *-set!: data, expr, accessors, ..., v
        free-keyword? *-set!
        quasisyntax ftype*-set!
          unsyntax transform-data syntax data
          expr, accessors, ..., v
      when
        any-set!: data, expr, accessors, ..., v
        free-keyword? any-set!
        quasisyntax ftype-any-set!
          unsyntax transform-data syntax data
          expr, accessors, ..., v
      when
        *-any-set!: data, expr, accessors, ..., v
        free-keyword? *-any-set!
        quasisyntax ftype*-any-set!
          unsyntax transform-data syntax data
          expr, accessors, ..., v
