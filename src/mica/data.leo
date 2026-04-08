library
  mica data
  export
    define-data
  import
    leo scheme
    mica data syntax
    mica ftype

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
            partial: transform-define-syntax-data-op, syntax name
            transform-data-ops
          unsyntax transform-define-syntax-data=? syntax name
          unsyntax transform-define-syntax-data-clear! syntax name
          unsyntax transform-define-syntax-data-fill! syntax name
          unsyntax transform-define-syntax-check-data=? syntax name
          define-syntax
            when
              :
                unsyntax datum->syntax: syntax name, 'let-data
                xs, ... ...
              let-ftype: xs, ... ...
