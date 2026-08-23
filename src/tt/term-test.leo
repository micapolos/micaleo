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
