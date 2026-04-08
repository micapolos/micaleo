import
  leo scheme
  mica data

define-data point struct
  x int
  y int

let-data
  with
    point-a point
    point-b point

  point-clear! point-a
  point-fill!: point-b, 0

  point-set!: point-a, x, 10
  point-set!: point-a, y, 20

  point-set!: point-b, x, 10
  point-set!: point-b, y, 20

  check equal?
    point-ref: point-a, x
    10

  check equal?
    point-ref: point-a, y
    20

  check equal?
    point=?: point-a, point-b
    true

  check-point=?: point-a, point-b
