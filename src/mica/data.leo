library
  mica data
  export
    define-data
  import
    leo scheme

  define
    transform-bit-field bit-field
    syntax-case bit-field
      when
        name boolean 1
        syntax name unsigned 1
      when
        other
        other

  define
    transform-ftype ftype
    syntax-case ftype
      when
        bits: bit-fields, ...
        free-keyword? bits
        quasisyntax bits
          unsyntax-splicing map transform-bit-fields
            syntax: bit-fields, ...



