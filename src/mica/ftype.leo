library
  mica ftype
  export
    let-ftype
    ftype-clear!
    ftype-fill!
    ftype-mem=?
    check-ftype=?
  import
    leo scheme
    mica memory

  define
    ftype-mem=?: ftype-pointer-a, ftype-pointer-b
    equal?
      ftype-pointer->sexpr ftype-pointer-a
      ftype-pointer->sexpr ftype-pointer-b

  define-syntax
    when
      ftype-clear!: ftype, pointer
      memory-clear!
        ftype-pointer-address pointer
        ftype-sizeof ftype

  define-syntax
    when
      ftype-fill!: ftype, pointer, u8
      memory-fill!
        ftype-pointer-address pointer
        ftype-sizeof ftype
        u8

  define-syntax
    keywords with
    when
      let-ftype
        with:
        x, xs, ...
      begin: x, xs, ...
    when
      let-ftype
        with: val ftype, bindings, ...
        x, xs, ...
      let*
        with
          address foreign-alloc ftype-sizeof ftype
          val make-ftype-pointer: ftype, address
        dynamic-wind
          lambda #f
          lambda let-ftype
            with: bindings, ...
            x, xs, ...
          lambda foreign-free address

  define-syntax
    when
      check-ftype=?: ftype-a, ftype-b
      let
        with
          sexpr-a ftype-pointer->sexpr ftype-a
          sexpr-b ftype-pointer->sexpr ftype-b
        when
          not equal?: sexpr-a, sexpr-b
          syntax-error
            syntax ftype-a
            `ftype mismatch
              expected` sexpr-a
              actual` sexpr-b
