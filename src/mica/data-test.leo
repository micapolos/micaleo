import
  leo scheme
  mica data

define-data point struct
  x int
  y int

define-data circle struct
  radius int
  center point

let-data
  with
    point-a point
    point-b point
    my-circle circle

  check equal?: data-sizeof point, 8
  check equal?: data-sizeof circle, 12

  point-clear! point-a
  point-fill!: point-b, 0

  point-set!: point-a, x, 10
  point-set!: point-a, y, 20

  point-set!: point-b, x, 10
  point-set!: point-b, y, 20

  circle-set!: my-circle, radius, 5
  circle-set!: my-circle, center, x, 10
  circle-set!: my-circle, center, y, 20

  check equal?
    point-ref: point-a, x
    10

  check equal?
    point-ref: point-a, y
    20

  check equal?
    data=?: point-a, point-b
    true

  check equal?
    data=?
      point-a
      circle-&ref: my-circle, center
    true

  check-data=?: point-a, point-b
