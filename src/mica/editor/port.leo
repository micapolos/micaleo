library
  mica editor port
  export put-cell
  import
    leo scheme
    mica ansi
    mica editor color
    mica editor cell

  define
    put-cell: port, cell

    let
      with color cell->foreground-color cell
      put-ansi
        port
        number->string
          add
            color-code color
            if: color-bright? color, 90, 30

    let
      with color cell->background-color cell
      put-ansi
        port
        number->string
          add
            color-code color
            if: color-bright? color, 100, 40

    put-char: port, cell->char cell
