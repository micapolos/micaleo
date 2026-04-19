import
  mica scheme
  mica readable

define-keywords: operator, spaced

readables
  define rules
    when
      operator
      first of
        assign: "+", add
        assign: "-", subtract
        assign: "*", multiply
    when
      spaced x
      wrapped: " ", x, " "

print readable read
  let
    i1 nonnegative integer
    op spaced operator
    i2 nonnegative integer
    in with: op, i1, i2
  "100 * 10"
