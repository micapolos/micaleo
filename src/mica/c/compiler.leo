library
  mica c compiler
  export compile
  import
    mica c base
    mica c type
    mica c keywords

  define
    type?-of+: type?-of, bindings
    lambda
      with id
      switch
        assp
          partial: free-identifier=?, id
          syntax->list bindings
        when
          _ false?
          type?-of id
        else ass cadr ass

  define
    compile: type?-of, stx
    syntax-case
      stx
      keywords: compiled, lambda, let, with
      when
        id
        and
          keyword? id
          type?-of syntax id
        quasisyntax :
          unsyntax type?-of syntax id
          id
      when
        compiled: t, x
        syntax : t, x
      when
        let
          with: ids exprs, ...
          xs, ..., x
        syntax-case
          map
            partial: compile, type?-of
            syntax exprs ...
          when
            : types exprs, ...
            syntax-case
              map
                partial
                  compile
                  type?-of+
                    type?-of
                    syntax : ids types, ...
                syntax->list syntax : xs, ..., x
              when
                : xs-types xs, ..., x-type x
                syntax :
                  x-type
                  let
                    with: ids exprs, ...
                    xs, ..., x
      when
        lambda
          with: ids types, ...
          xs, ..., x
        syntax-case
          map
            partial
              compile
              type?-of+
                type?-of
                syntax : ids types, ...
            syntax->list syntax : xs, ..., x
          when
            : xs-types xs, ..., x-type x
            syntax :
              lambda
                with: types, ...
                x-type
              lambda
                with: ids, ...
                xs, ..., x
      when
        fn: args, ...
        syntax-case
          quasisyntax :
            unsyntax compile: type?-of, syntax fn
            unsyntax-splicing map
              partial: compile, type?-of
              syntax args ...
          when
            : fn-type fn, arg-types args, ...
            syntax-case
              syntax fn-type
              keywords: lambda, with
              when
                lambda
                  with: param-types, ...
                  return-type
                begin
                  apply-type-check
                    stx
                    syntax param-types ...
                    syntax arg-types ...
                    syntax args ...
                  syntax :
                    return-type
                    fn: args, ...
              when
                other
                syntax-error
                  syntax fn-type
                  'not lambda
      when
        other
        syntax-error: syntax other, 'compile error
