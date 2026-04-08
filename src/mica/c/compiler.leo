library
  mica c compiler
  export compile
  import
    mica c base
    mica c type

  define
    typeof+: typeof, bindings
    lambda
      with id
      switch
        assp
          partial: free-identifier=?, id
          syntax->list bindings
        when
          _ false?
          typeof id
        else ass cadr ass

  define
    compile: typeof, stx
    syntax-case
      stx
      keywords: lambda, let, with
      when
        let
          with: ids exprs, ...
          xs, ..., x
        syntax-case
          map
            partial: compile, typeof
            syntax exprs ...
          when
            : types exprs, ...
            syntax-case
              map
                partial
                  compile
                  typeof+
                    typeof
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
              typeof+
                typeof
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
            unsyntax compile: typeof, syntax fn
            unsyntax-splicing map
              partial: compile, typeof
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
        id
        keyword? id
        quasisyntax :
          unsyntax typeof syntax id
          id
      when
        fx
        fixnum? datum fx
        syntax : fixnum, fx
