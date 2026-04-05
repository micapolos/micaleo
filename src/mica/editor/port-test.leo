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
      char-background-color-foreground-color->cell
        char Z
        white-color
        black-color
  call-with-string-output-port lambda
    with port
    put-ansi: port, "30m"
    put-ansi: port, "47m"
    put-char: port, char Z
