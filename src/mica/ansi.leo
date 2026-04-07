library
  mica ansi
  export
    char-ansi-terminator?

    sgr-ansi

    reset-ansi
    home-ansi

    bold-ansi
    underline-ansi
    invert-ansi

    save-position-ansi
    restore-position-ansi

    hide-cursor-ansi
    show-cursor-ansi

    up-ansi
    down-ansi
    right-ansi
    left-ansi

    put-ansi
  import
    leo scheme

  define
    sgr-ansi: command
    string-append: command, "m"

  define
    char-ansi-terminator? char
    let
      with code char->integer char
      and
        >=: code, 64
        <=: code, 127

  define reset-ansi "0m"
  define home-ansi "H"

  define bold-ansi "1m"
  define underline-ansi "4m"
  define invert-ansi "7m"

  define save-position-ansi "s"
  define restore-position-ansi "u"

  define hide-cursor-ansi "?25l"
  define show-cursor-ansi "?25h"

  define
    move-ansi: direction, count
    string-append: number->string count, direction

  define up-ansi partial: move-ansi, "A"
  define down-ansi partial: move-ansi, "B"
  define right-ansi partial: move-ansi, "C"
  define left-ansi partial: move-ansi, "D"

  define
    put-ansi: port, ansi
    put-char: port, char code 27
    put-char: port, char left-square-bracket
    put-string: port, ansi
