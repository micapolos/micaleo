library
  mica bytevector-slice
  export
    make-bytevector-slice
    bytevector-slice?
    bytevector-slice-bytevector
    bytevector-slice-start
    bytevector-slice-length

    bytevector-slice->bytevector
  import
    leo scheme

  define-record bytevector-slice
    bytevector
    start
    length

  define
    bytevector-slice->bytevector bytevector-slice
    let*
      with
        length bytevector-slice-length bytevector-slice
        bytevector make-bytevector length
      bytevector-copy!
        bytevector-slice-bytevector bytevector-slice
        bytevector-slice-start bytevector-slice
        bytevector
        0
        length
      bytevector

  record-type-equal-procedure
    record-type-descriptor bytevector-slice
    lambda
      with: first-bytevector-slice, second-bytevector-slice, recurse
      recurse
        bytevector-slice->bytevector first-bytevector-slice
        bytevector-slice->bytevector second-bytevector-slice

  record-type-hash-procedure
    record-type-descriptor bytevector-slice
    lambda
      with: bytevector-slice, recurse
      recurse bytevector-slice->bytevector bytevector-slice
