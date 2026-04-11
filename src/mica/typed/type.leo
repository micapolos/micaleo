library
  mica typed type
  export
    type
    int, uint, float
    int-8, uint-8
    int-16, uint-16
    int-32, uint-32
    int64, uint-64
    float-32
    float-64
    type-assignable?
  import
    mica typed base

  define-keywords
    type
    int, uint, float
    int-8, uint-8
    int-16, uint-16
    int-32, uint-32
    int64, uint-64
    float-32
    float-64

  define
    type-assignable?: type, from-type
    syntax-case
      type
      keywords: lambda, with
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
