library
  mica ansi
  export
    put-ansi
  import
    leo scheme

  define
    put-ansi: port, string
    put-char: port, char code 27
    put-char: port, char left-square-bracket
    put-string: port, string
    put-char: port, char m
