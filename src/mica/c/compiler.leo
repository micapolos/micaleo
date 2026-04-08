library
  mica c compiler
  export compile
  import mica c base

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
      keywords: let, with
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
        id
        keyword? id
        quasisyntax :
          unsyntax typeof syntax id
          id
      when
        fx
        fixnum? datum fx
        syntax : fixnum, fx
