library
  mica pointer
  export
    make-pointer
    pointer?
    pointer-ftype-pointer
    pointer-bytevector-slice

    ftype-make-pointer
    pointer->datum
  import
    leo scheme
    mica bytevector-slice

  define-record pointer
    ftype-pointer
    bytevector-slice

  define-syntax rules
    when
      ftype-make-pointer ftype
      let*
        with
          length ftype-sizeof ftype
          bytevector make-immobile-bytevector length
        make-pointer
          make-ftype-pointer
            ftype
            object->reference-address bytevector
          make-bytevector-slice: bytevector, 0, length

  define
    pointer->datum pointer
    `pointer` ftype-pointer->sexpr pointer-ftype-pointer pointer

  record-type-equal-procedure
    record-type-descriptor pointer
    lambda
      with: first-pointer, second-pointer, recurse
      and
        recurse
          pointer-ftype-pointer first-pointer
          pointer-ftype-pointer second-pointer
        recurse
          pointer-bytevector-slice first-pointer
          pointer-bytevector-slice second-pointer

  record-type-hash-procedure
    record-type-descriptor pointer
    lambda
      with: pointer, recurse
      equal-hash vector
        recurse pointer-ftype-pointer pointer
        recurse pointer-bytevector-slice pointer
