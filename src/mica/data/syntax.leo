library
  mica data syntax
  export
    transform-data
    transform-access
    transform-path
    transform-data-op
    transform-data-ops
    transform-define-syntax-data-op
    transform-define-syntax-data-clear!
    transform-define-syntax-data-fill!

  import
    leo scheme
    mica ftype

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
    transform-access: lookup-data, access
    syntax-case
      access
      when
        access: name, accessor
        keyword? name
        transform-access
          lookup-data
          quasisyntax access
            unsyntax lookup-data syntax name
            accessor
      when
        access
          struct: fields, ...
          accessor
        free-keyword? struct
        field-ref
          syntax fields ...
          syntax accessor
      when
        access
          bits: fields, ...
          accessor
        free-keyword? bits
        syntax :
      when
        access
          array: size, element-data
          accessor
        free-keyword? array
        syntax element-data

  define
    transform-path: lookup-data, path
    syntax-case
      path
      when
        path data
        syntax data
      when
        path: data, accessor, accessors, ...
        syntax-case
          transform-access
            lookup-data
            syntax access: data, accessor
          when
            :
            if
              not null? syntax accessors ...
              then syntax-error
                syntax accessors ...
                'invalid accessors
              else
                syntax :
          when
            child-data
            transform-path
              lookup-data
              syntax path: child-data, accessors, ...

  define transform-data-ops list
    syntax ref
    syntax *-ref
    syntax &ref
    syntax *-&ref
    syntax any-ref
    syntax *-any-ref
    syntax set!
    syntax *-set!
    syntax any-set!
    syntax *-any-set!

  define
    data-op-needs-minus? op
    let
      with first-char string-ref: symbol->string syntax->datum op, 0
      or
        char-alphabetic? first-char
        char=?: first-char, #\&

  define
    transform-data-op-identifier: name, op
    if
      data-op-needs-minus? op
      then identifier-append: name, name, syntax -, op
      else identifier-append: name, name, op

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

  define
    transform-define-syntax-data-op: name, op
    quasisyntax define-syntax
      when
        :
          unsyntax transform-data-op-identifier: name, op
          x, ... ...
        unsyntax transform-data-op quasisyntax
          :
            unsyntax op
            unsyntax name
            x, ... ...

  define
    transform-define-syntax-data-clear! name
    quasisyntax define-syntax when
      :
        unsyntax identifier-append: name, name, syntax -, syntax clear!
        x
      ftype-clear!: unsyntax name, x

  define
    transform-define-syntax-data-fill! name
    quasisyntax define-syntax when
      :
        unsyntax identifier-append: name, name, syntax -, syntax fill!
        x, v
      ftype-fill!: unsyntax name, x, v
