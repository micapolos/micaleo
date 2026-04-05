import
  leo scheme
  mica ansi

check char-ansi-terminator? char a
check not char-ansi-terminator? char 0

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
