library
  mica typed type
  export
    type-case
    type
    boolean, char
    int, uint, float
    int-8, uint-8
    int-16, uint-16
    int-32, uint-32
    int-64, uint-64
    float-32
    float-64
    array
    struct
    union
    bits
    type-size
    type-assignable?
  import
    mica typed base

  define-keywords
    type
    boolean, char
    int, uint, float
    int-8, uint-8
    int-16, uint-16
    int-32, uint-32
    int-64, uint-64
    float-32
    float-64
    array
    struct
    union
    bits

  define-syntax
    when
      type-case: type, patterns, ...
      syntax-case
        type
        keywords
          boolean, char
          int, uint, float
          int-8, uint-8
          int-16, uint-16
          int-32, uint-32
          int-64, uint-64
          float-32
          float-64
          array
          struct
          union
          bits
        patterns, ...

  define
    field-size: native-size, field
    syntax-case
      field
      when
        name type
        type-size: native-size, syntax type

  define
    bit-field-size: native-size, bit-field
    syntax-case
      bit-field
      keywords boolean
      when
        name boolean
        1
      when
        name signedness size
        datum size

  define
    type-size: native-size, type
    syntax-case
      type
      keywords
        boolean, char
        int, uint, float
        int-8, uint-8
        int-16, uint-16
        int-32, uint-32
        int-64, uint-64
        float-32
        float-64
        array
        struct
        union
        bits
      when: boolean, 1
      when: char, 4
      when: int, native-size
      when: uint, native-size
      when: float, native-size
      when: int-8, 1
      when: int-16, 2
      when: int-32, 4
      when: int-64, 8
      when: uint-8, 1
      when: uint-16, 2
      when: uint-32, 4
      when: uint-64, 8
      when: float-32, 4
      when: float-64, 8
      when
        array: size, element-type
        *
          datum size
          type-size: native-size, syntax element-type
      when
        struct: fields, ...
        fold-left
          +, 0
          map
            partial: field-size, native-size
            syntax fields ...
      when
        bits: bit-fields, ...
        div
          fold-left
            +, 0
            map
              partial: bit-field-size, native-size
              syntax bit-fields ...
          8
      when
        union: fields, ...
        apply
          max
          map
            partial: field-size, native-size
            syntax fields ...

  define
    type-assignable?: type, from-type
    type-case
      type
      when
        id
        keyword? id
        type-case
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
      when
        array: size, type
        #f
      when
        struct: fields, ...
        #f
      when
        union: fields, ...
        #f
      when
        bits: fields, ...
        #f
