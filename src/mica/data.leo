library
  mica data
  export
    define-data
  import
    leo scheme

  define-keywords: data

  define-syntax
    define-data stx

    define
      transform-field field
      syntax-case
        field
        when
          name type
          quasisyntax name unsyntax transform-ftype syntax type

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
      transform-ftype ftype
      syntax-case
        ftype
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

    syntax-case
      stx
      when
        _ name type
        keyword? name
        quasisyntax begin
          define-ftype name unsyntax transform-ftype syntax type
          define-property: name, data, syntax type
