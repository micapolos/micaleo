library
  mica typed type
  export
    type
    int, uint, float
    native-int, native-float
    type-assignable?
  import
    mica typed base

  define-keywords
    type
    int, uint, float
    native-int, native-float

  define
    type-assignable?: type, from-type
    syntax-case
      type
      keywords: native-int, native-float, char, int, uint, float, lambda, with
      when
        native-int
        syntax-case
          from-type
          keywords: native-int
          when: native-int, #t
          when: _, #f
      when
        native-float
        syntax-case
          from-type
          keywords: native-float
          when: native-float, #t
          when: _, #f
      when
        char
        syntax-case
          from-type
          keywords: char
          when: char, #t
          when: _, #f
      when
        int n
        syntax-case
          from-type
          keywords: int
          when
            int from-n
            =: datum n, datum from-n
          when: _, #f
      when
        uint n
        syntax-case
          from-type
          keywords: uint
          when
            uint from-n
            =: datum n, datum from-n
          when: _, #f
      when
        float n
        syntax-case
          from-type
          keywords: float
          when
            float from-n
            =: datum n, datum from-n
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
