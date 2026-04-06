import
  leo scheme
  mica bytevector-slice

check equal?
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    0, 2
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    0, 2

check not equal?
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    0, 2
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    1, 2

check equal?
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    0, 2
  make-bytevector-slice
    bytevector: 1, 2, 1, 2
    2, 2
