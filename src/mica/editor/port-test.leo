import
  leo scheme
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
  string
    char code 27
    char left-square-bracket
    char 3
    char 0
    char m
    char code 27
    char left-square-bracket
    char 4
    char 7
    char m
    char Z
