library
  mica c type
  export
    type-assignable?
    type-error
    type-check
  import
    leo scheme
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
      when: _, #f
