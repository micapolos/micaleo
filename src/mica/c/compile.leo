library
  mica c compile
  export
    compile
    typeof
    valueof
  import
    mica c base

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
    type-error: type, arg-type, arg
    syntax-error
      arg
      `invalid type` syntax->datum arg-type
      `expected` syntax->datum type

  define
    type-check: type<=?, type, arg-type, arg
    unless
      type<=?: arg-type, type
      type-error: type, arg-type, arg

  define
    apply-type-check: type<=?, stx, param-types, arg-types, args
    unless
      =
        length param-types
        length arg-types
      syntax-error
        stx
        `invalid argument count` length arg-types
        `expected` length param-types
    for-each
      partial: type-check, type<=?
      param-types
      arg-types
      args

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
    compile-of: compile?, type<=?, type, stx
    syntax-case
      compile: compile?, type<=?, stx
      when
        : t, v
        begin
          type-check: type<=?, syntax t, type, stx
          syntax v

  define
    compile: compile?, type<=?, stx
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
              partial: compile, compile?, type<=?
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
                    type<=?
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
                type<=?
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
              a compile-of: compile?, type<=?, syntax boolean, syntax a
              b compile: compile?, type<=?, syntax b
              c compile-of: compile?, type<=?, typeof b, syntax c
            quasisyntax :
              unsyntax typeof b
              if: unsyntax a, unsyntax valueof b, unsyntax c
        when
          fn: args, ...
          syntax-case
            quasisyntax :
              unsyntax compile: compile?, type<=?, syntax fn
              unsyntax-splicing map
                partial: compile, compile?, type<=?
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
                      type<=?
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
