import
  leo scheme
  mica ansi

check equal?
  call-with-string-output-port lambda
    with port
    put-ansi: port, "foo"
  string
    char code 27
    char left-square-bracket
    char f
    char o
    char o
    char m
