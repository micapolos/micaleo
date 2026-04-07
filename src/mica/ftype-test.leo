import
  leo scheme
  mica ftype

define-ftype point struct: x int, y int

let-ftype
  with
    point-a point
    point-b point

  ftype-set!: point, point-a, x, 10
  ftype-set!: point, point-a, y, 20
  ftype-set!: point, point-b, x, 10
  ftype-set!: point, point-b, y, 20

  check-ftype=?: point-a, point-b
