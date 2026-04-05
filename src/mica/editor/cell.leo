library
  mica editor cell
  export
    char-bg-fg->cell
    cell->char-bg-fg
  import
    leo scheme

  define
    char-bg-fg->cell: char, bg, fg
    fxior
      char->integer char
      fxsll: bg, 20
      fxsll: fg, 24

  define
    cell->char-bg-fg cell
    values
      integer->char fxand
        cell
        1048575
      fxand
        fxsrl: cell, 20
        15
      fxand
        fxsrl: cell, 24
        15
