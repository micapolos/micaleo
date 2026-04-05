import
  leo scheme
  mica ansi
  mica editor cell
  mica editor color
  mica editor port

check equal?
  call-with-string-output-port lambda
    with port
    put-cell
      port
      cell
        char Z
        background color white
        foreground color black
  call-with-string-output-port lambda
    with port
    put-ansi: port, "30m"
    put-ansi: port, "47m"
    put-char: port, char Z
