library
  mica ftype-pointer
  export
    let-ftype
    ftype-mem=?
  import
    leo scheme

  define
    ftype-mem=?: ftype-pointer-a, ftype-pointer-b
    equal?
      ftype-pointer->sexpr ftype-pointer-a
      ftype-pointer->sexpr ftype-pointer-b

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
            object->reference-address make-immobile-bytevector ftype-sizeof ftype
          ...
        x, xs, ...
