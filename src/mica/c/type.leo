library
  mica c type
  export
    type-assignable?
    type-error
    type-check
    apply-type-check
    simple->foreign-type
  import
    mica c base
    mica c keywords

  define
    type-error: type, arg-type, arg
    syntax-error
      arg
      `invalid
        type` syntax->datum arg-type
        expected` syntax->datum type

  define
    type-check: type, arg-type, arg
    unless
      type-assignable?: type, arg-type
      type-error: type, arg-type, arg

  define
    apply-type-check: stx, param-types, arg-types, args
    unless
      =
        length param-types
        length arg-types
      syntax-error
        stx
        `invalid
          argument count` length arg-types
          expected` length param-types
    for-each
      type-check
      param-types
      arg-types
      args

  define
    type-assignable?: type, from-type
    syntax-case
      type
      keywords: char, short, int, long, signed, unsigned, wide, float, double, size, lambda, with
      when
        char
        syntax-case
          from-type
          keywords: char
          when: char, #t
          when: _, #f
      when
        wide char
        syntax-case
          from-type
          keywords: wide, char
          when: wide char, #t
          when: _, #f
      when
        short
        syntax-case
          from-type
          keywords: short
          when: short, #t
          when: _, #f
      when
        unsigned short
        syntax-case
          from-type
          keywords: unsigned, short
          when: unsigned short, #t
          when: _, #f
      when
        int
        syntax-case
          from-type
          keywords: int
          when: int, #t
          when: _, #f
      when
        unsigned int
        syntax-case
          from-type
          keywords: unsigned, int
          when: unsigned int, #t
          when: _, #f
      when
        long
        syntax-case
          from-type
          keywords: long
          when: long, #t
          when: _, #f
      when
        unsigned long
        syntax-case
          from-type
          keywords: unsigned, long
          when: unsigned long, #t
          when: _, #f
      when
        size
        syntax-case
          from-type
          keywords: size
          when: size, #t
          when: _, #f
      when
        signed size
        syntax-case
          from-type
          keywords: signed, size
          when: signed size, #t
          when: _, #f
      when
        float
        syntax-case
          from-type
          keywords: float
          when: float, #t
          when: _, #f
      when
        double
        syntax-case
          from-type
          keywords: double
          when: double, #t
          when: _, #f
      when
        id
        keyword? id
        syntax-case
          from-type
          when
            from-id
            keyword? from-id
            free-identifier=?: syntax id, syntax from-id
          when: _, #f
      when
        lambda
          with: param-type, ...
          result-type
        syntax-case
          from-type
          when
            lambda
              with: from-param-type, ...
              from-result-type
            and
              =
                length syntax param-type ...
                length syntax from-param-type ...
              for-each
                type-assignable?
                syntax from-param-type ...
                syntax param-type ...
              type-assignable?
                syntax result-type
                syntax from-result-type
          when: _, #f
      when: _, #f

  define
    simple->foreign-type type
    syntax-case
      type
      keywords: char, short, int, long, signed, unsigned, wide, float, double, size
      when: char, 'char
      when: wide char, 'wchar
      when: short, 'short
      when: unsigned short, 'unsigned-short
      when: int, 'int
      when: unsigned int, 'unsigned-int
      when: long, 'long
      when: unsigned long, 'unsigned-long
      when: size, 'size_t
      when: signed size, 'ssize_t
      when: float, 'float
      when: double, 'double
      when
        _
        syntax-error: type, 'non simple type
