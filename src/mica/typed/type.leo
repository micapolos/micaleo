library
  mica typed type
  export
    type
    int, uint, float
    type-assignable?
  import
    mica typed base

  define-keywords
    type
    int, uint, float

  define
    type-assignable?: type, from-type
    syntax-case
      type
      keywords: boolean, char, int, uint, float, lambda, with
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
        boolean
        syntax-case
          from-type
          keywords: boolean
          when: boolean, #t
          when: _, #f
      when
        int
        syntax-case
          from-type
          keywords: int
          when: int, #t
          when: _, #f
      when
        float
        syntax-case
          from-type
          keywords: float
          when: float, #t
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
