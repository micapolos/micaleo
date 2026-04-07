library
  mica editor color
  export
    fcolors

    color
    bright, black, red, green, yellow, blue, magenta, cyan, white

    color-bits

    color-bright?
    color-code

    color->datum
  import
    leo scheme

  define-ftype fcolors bits
    background-bright? unsigned 1
    background-color unsigned 3
    foreground-bright? unsigned 1
    foreground-color unsigned 3

  define color-bits 4

  define
    color-bright? color
    not zero? fxand: color, 8

  define
    color-code color
    fxand: color, 7

  define-keywords: bright, black, red, green, yellow, blue, magenta, cyan, white

  define-syntax
    keywords: bright, black, red, green, yellow, blue, magenta, cyan, white
    when: color black, 0
    when: color red, 1
    when: color green, 2
    when: color yellow, 3
    when: color blue, 4
    when: color magenta, 5
    when: color cyan, 6
    when: color white, 7
    when: color bright black, 8
    when: color bright red, 9
    when: color bright green, 10
    when: color bright yellow, 11
    when: color bright blue, 12
    when: color bright magenta, 13
    when: color bright cyan, 14
    when: color bright white, 15

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
