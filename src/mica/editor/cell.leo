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

  define
    char-bg-fg->cell: char, bg, fg
    fxior
      char->integer char
      fxsll: bg, 20
      fxsll: fg, 24

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
      1048575

  define
    cell->bg cell
    fxand
      fxsrl: cell, 20
      15

  define
    cell->fg cell
    fxand
      fxsrl: cell, 24
      15
