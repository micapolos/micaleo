import
  mica scheme
  mica readable

print readable read
  let
    i1 nonnegative integer
    ununsed " "
    op first of
      assign: "+", add
      assign: "-", subtract
      assign: "*", multiply
    ununsed " "
    i2 nonnegative integer
    in with: op, i1, i2
  "123 * 1"
