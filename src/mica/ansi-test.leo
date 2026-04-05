import
  leo scheme
  mica ansi

check equal?
  call-with-string-output-port lambda
    with port
    put-ansi: port, "03m"
  string
    char code 27
    char left-square-bracket
    char 0
    char 3
    char m
