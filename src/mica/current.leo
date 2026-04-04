library
  mica current
  export
    current
  import
    leo scheme

  define syntax
    keywords: let, in
    when
      current let
        var expr
        in body
      let
        v expr
        b body
        in quasisyntax
          let
            unsyntax v
            in unsyntax b
    when
      current x
      syntax x
