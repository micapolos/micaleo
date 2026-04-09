library
  mica c compile
  export
    compile
    typeof
    valueof
  import
    mica c base
    mica c type

  define
    typeof: stx
    syntax-case
      stx
      when
        : t, v
        syntax t

  define
    valueof: stx
    syntax-case
      stx
      when
        : t, v
        syntax v

  define
    compile-binding binding
    quasisyntax :
      unsyntax cadr binding
      unsyntax car binding

  define
    compile?+: compile?, bindings
    lambda
      with stx
      or
        and
          identifier? stx
          let
            with binding? assp
              partial: free-identifier=?, stx
              syntax->list bindings
            and: binding?, compile-binding binding?
        compile? stx

  define
    compile-of: compile?, type, stx
    syntax-case
      compile: compile?, stx
      when
        : t, v
        begin
          type-check: syntax t, type, stx
          syntax v

  define
    compile: compile?, stx
    or
      compile? stx
      syntax-case
        stx
        keywords: if, lambda, let, with
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
          if: a, b, c
          let*
            with
              a compile-of: compile?, syntax boolean, syntax a
              b compile: compile?, syntax b
              c compile-of: compile?, typeof b, syntax c
            quasisyntax :
              unsyntax typeof b
              if: unsyntax a, unsyntax valueof b, unsyntax c
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
                    syntax fn
                    `invalid type` datum other
                    `expected lambda
        when
          other
          syntax-error: syntax other, 'compile error
