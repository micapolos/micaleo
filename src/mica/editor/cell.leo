library
  mica editor cell
  export
    char-bg-fg->cell
    cell->char-bg-fg
    cell->char
    cell->bg
    cell->fg
  import
    leo scheme

  define char-bits 21
  define bg-bits 4
  define fg-bits 4
  define bg-shift char-bits
  define fg-shift fx+: bg-shift, bg-bits

  define char-mask fx1- fxsll: 1, char-bits
  define bg-mask fx1- fxsll: 1, bg-bits
  define fg-mask fx1- fxsll: 1, fg-bits

  define
    char-bg-fg->cell: char, bg, fg
    fxior
      char->integer char
      fxsll: bg, bg-shift
      fxsll: fg, fg-shift

  define
    cell->char-bg-fg cell
    values
      cell->char cell
      cell->bg cell
      cell->fg cell

  define
    cell->char cell
    integer->char fxand
      cell
      char-mask

  define
    cell->bg cell
    fxand
      fxsrl: cell, bg-shift
      bg-mask

  define
    cell->fg cell
    fxand
      fxsrl: cell, fg-shift
      fg-mask
