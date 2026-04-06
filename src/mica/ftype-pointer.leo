library
  mica ftype-pointer
  export
    let-ftype
    ftype-clear!
    ftype-mem=?
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
      memory-clear!: ftype-pointer-address, ftype-sizeof ftype

  define-syntax
    when
      let-ftype
        with
          val ftype
          ...
        x, xs, ...
      let
        with
          val make-ftype-pointer
            ftype
            object->reference-address make-immobile-bytevector: ftype-sizeof ftype
          ...
        x, xs, ...
