library
  mica data
  export
    define-data
  import
    leo scheme
    mica data syntax

  define-keywords: data

  define-syntax
    define-data stx
    syntax-case
      stx
      when
        _ name spec
        keyword? name
        quasisyntax begin
          define-ftype name unsyntax transform-data syntax spec
          define-property name data syntax spec
          unsyntax-splicing map
            partial: transform-data-define-syntax, syntax name
            transform-data-ops
