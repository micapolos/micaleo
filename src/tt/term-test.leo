import
  leo scheme
  tt term

check binding=?
  0
  binding
    1
    lambda: with x, x
  binding
    1
    lambda: with x, x

check binding=?
  0
  binding
    infinity
    lambda: with x, x
  binding
    infinity
    lambda: with x, x

check not binding=?
  0
  binding
    1
    lambda: with x, x
  binding
    infinity
    lambda: with x, x

check equal?
  binding->datum
    0
    binding
      0
      lambda
        with: x
        x
  'binding
    0
    lambda
      with $0
      $0
