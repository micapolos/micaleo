library
  mica editor cell
  export
    fcell
    cell
    background
    foreground
    cell->char
    cell->background-color
    cell->foreground-color
    cell->datum
  import
    leo scheme
    mica editor color

  define-ftype fcell packed struct
    colors fcolors
    data bits
      bold? unsigned 1
      italic? unsigned 1
      underline? unsigned 1
      char-code unsigned 21

  define-keywords: foreground, background

  define-syntax
    keywords: background, foreground
    rules when
      cell: ch, background bg, foreground fg
      make-cell: ch, bg, fg

  define char-bits 21
  define background-color-bits color-bits
  define foreground-color-bits color-bits
  define background-color-shift char-bits
  define foreground-color-shift fx+: background-color-shift, background-color-bits

  define char-mask fx1- fxsll: 1, char-bits
  define background-color-mask fx1- fxsll: 1, background-color-bits
  define foreground-color-mask fx1- fxsll: 1, foreground-color-bits

  define
    make-cell: char, background-color, foreground-color
    fxior
      char->integer char
      fxsll: background-color, background-color-shift
      fxsll: foreground-color, foreground-color-shift

  define
    cell->char cell
    integer->char fxand
      cell
      char-mask

  define
    cell->background-color cell
    fxand
      fxsrl: cell, background-color-shift
      background-color-mask

  define
    cell->foreground-color cell
    fxand
      fxsrl: cell, foreground-color-shift
      foreground-color-mask

  define
    cell->datum cell
    'cell'
      cell->char cell
      'background' color->datum cell->background-color cell
      'foreground' color->datum cell->foreground-color cell
