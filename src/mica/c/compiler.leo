library
  mica c compiler
  export compile
  import
    mica c base
    mica c type

  define
    compile?+: compile?, bindings
    lambda
      with stx
      or
        and
          identifier? stx
          let
            with ass? assp
              partial: free-identifier=?, stx
              syntax->list bindings
            and
              ass?
              quasisyntax :
                unsyntax cadr ass?
                unsyntax car ass?
        compile? stx

  define
    compile: compile?, stx
    or
      compile? stx
      syntax-case
        stx
        keywords: lambda, let, with
        when
          let
            with: ids exprs, ...
            xs, ..., x
          syntax-case
            map
              partial: compile, compile?
              syntax exprs ...
            when
              : types exprs, ...
              syntax-case
                map
                  partial
                    compile
                    compile?+
                      compile?
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
                compile?+
                  compile?
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
              unsyntax compile: compile?, syntax fn
              unsyntax-splicing map
                partial: compile, compile?
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
