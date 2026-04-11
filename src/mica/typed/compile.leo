library
  mica typed compile
  export
    compile
    typeof
    valueof
  import
    mica typed base
    mica typed type

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
    type-check: type, arg-type, arg
    unless
      type-assignable?: type, arg-type
      type-error: type, arg-type, arg

  define
    apply-type-check: stx, param-types, arg-types, args
    unless
      =
        length param-types
        length arg-types
      syntax-error
        stx
        `invalid argument count` length arg-types
        `expected` length param-types
    for-each
      type-check
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
          b
          boolean? datum b
          syntax : boolean, b
        when
          i
          integer? datum i
          syntax : int, i
        when
          r
          real? datum r
          syntax : float, r
        when
          ch
          char? datum ch
          syntax : char, ch
        when
          s
          string? datum s
          syntax : string, s
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
