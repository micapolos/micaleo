library
  mica editor color
  export
    color-bits

    color-bright?
    color-code

    black-color
    red-color
    green-color
    yellow-color
    blue-color
    magenta-color
    cyan-color
    white-color

    bright-black-color
    bright-red-color
    bright-green-color
    bright-yellow-color
    bright-blue-color
    bright-magenta-color
    bright-cyan-color
    bright-white-color

    color->datum
  import
    leo scheme

  define color-bits 4

  define
    color-bright? color
    not zero? fxand: color, 8

  define
    color-code color
    fxand: color, 7

  define black-color 0
  define red-color 1
  define green-color 2
  define yellow-color 3
  define blue-color 4
  define magenta-color 5
  define cyan-color 6
  define white-color 7

  define bright-black-color 8
  define bright-red-color 9
  define bright-green-color 10
  define bright-yellow-color 11
  define bright-blue-color 12
  define bright-magenta-color 13
  define bright-cyan-color 14
  define bright-white-color 15

  define color-code-datums vector
    'black
    'red
    'green
    'yellow
    'blue
    'magenta
    'cyan
    'white

  define
    color->datum color
    `color`
      let
        with code-datum vector-ref: color-code-datums, color-code color
        if
          color-bright? color
          then `bright` code-datum
          else code-datum
