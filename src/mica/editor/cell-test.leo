import
  leo scheme
  mica editor color
  mica editor cell

let*-values
  with
    with
      values cell
      char-background-color-foreground-color->cell: char a, red-color, bright-cyan-color
    with
      values: ch, background-color, foreground-color
      cell->char-background-color-foreground-color cell
  check equal?: ch, char a
  check equal?: background-color, red-color
  check equal?: foreground-color, bright-cyan-color

check equal?
  cell->datum char-background-color-foreground-color->cell: char a, red-color, bright-cyan-color
  `cell`
    char a
    `background color red
    `foreground color bright cyan
