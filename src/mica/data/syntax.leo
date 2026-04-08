library
  mica data syntax
  export
    transform-data
    transform-data-op
    transform-data-ops
    transform-define-syntax-data-op
    transform-define-syntax-data->datum
    transform-define-syntax-data=?
    transform-define-syntax-data-clear!
    transform-define-syntax-data-fill!
    transform-define-syntax-let-data
    transform-define-syntax-check-data=?

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
          unsyntax if
            char-alphabetic? string-ref: symbol->string syntax->datum op, 0
            then identifier-append: name, name, syntax -, op
            else identifier-append: name, name, op
          x, ... ...
        unsyntax transform-data-op quasisyntax
          :
            unsyntax op
            unsyntax name
            x, ... ...

  define
    transform-define-syntax-data->datum name
    quasisyntax define-syntax when
      :
        unsyntax identifier-append: name, name, syntax ->datum
        x
      ftype-pointer->sexpr: x

  define
    transform-define-syntax-data=? name
    quasisyntax define-syntax when
      :
        unsyntax identifier-append: name, name, syntax =?
        a, b
      ftype-mem=?: a, b

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

  define
    transform-define-syntax-let-data name
    quasisyntax define-syntax
      when
        :
          unsyntax datum->syntax: name, 'let-data
          xs, ... ...
        let-ftype: xs, ... ...

  define
    transform-define-syntax-check-data=? name
    quasisyntax define-syntax when
      :
        unsyntax identifier-append: name, syntax check, syntax -, name, syntax =?
        a, b
      check-ftype=?: a, b
