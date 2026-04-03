library
  mica pot
  export nearest-pot
  import leo scheme

  define lambda
    nearest-pot n
    if
      zero? n
      then 0
      else ash
        1
        bitwise-length subtract: n, 1
