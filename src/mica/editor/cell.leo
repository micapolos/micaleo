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

  comment
    unicode bits: from 0, to 21
    background color bits: from 0, to 25
    foreground color bits: from 26, to 29

  define
    char-bg-fg->cell: char, bg, fg
    fxior
      char->integer char
      fxsll: bg, 21
      fxsll: fg, 25

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
      fx1- fxsll: 1, 21

  define
    cell->bg cell
    fxand
      fxsrl: cell, 21
      15

  define
    cell->fg cell
    fxand
      fxsrl: cell, 25
      15
