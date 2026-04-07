import
  leo scheme
  mica data syntax

check equal?
  syntax->datum transform-data syntax struct
    x int
    y int
    flags bits
      enabled? boolean 1
      value unsigned 7
  'struct
    x int
    y int
    flags bits
      enabled? unsigned 1
      value unsigned 7
