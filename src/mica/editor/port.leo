library
  mica editor port
  export put-cell
  import
    leo scheme
    mica ansi
    mica editor color
    mica editor cell

  define
    color-base->ansi: color, base
    number->string add
      base
      color-code color
      if: color-bright? color, 60, 0

  define
    put-color-base: port, color, base
    put-ansi
      port
      color-base->ansi: color, base

  define
    put-cell: port, cell
    put-color-base: port, cell->foreground-color cell, 30
    put-color-base: port, cell->background-color cell, 40
    put-char: port, cell->char cell
