import
  leo scheme
  mica pointer

define-ftype point-ftype struct
  x float
  y float

define point-pointer
  ftype-make-pointer point-ftype

todo check equal structure
check equal?
  point-pointer
  point-pointer
