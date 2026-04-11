library
  mica data
  export
    data
    define-data
    data-sizeof
    data=?
    data->datum
    let-data
    check-data=?

  import
    leo scheme
    mica data syntax
    mica ftype

  define-keyword data

  define-syntax rules
    when
      data-sizeof x
      ftype-sizeof x
    when
      data=?: a, b
      ftype-mem=?: a, b
    when
      data->datum x
      ftype-pointer->sexpr x
    when
      let-data: xs, ...
      let-ftype: xs, ...
    when
      check-data=?: a, b
      check-ftype=?: a, b

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
          unsyntax transform-define-syntax-data-clear! syntax name
          unsyntax transform-define-syntax-data-fill! syntax name
