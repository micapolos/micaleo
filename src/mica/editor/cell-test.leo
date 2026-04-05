import
  leo scheme
  mica editor color
  mica editor cell

let*-values
  with
    with
      values cell
      char-background-color-foreground-color->cell: char a, color red, color bright cyan
    with
      values: ch, background-color, foreground-color
      cell->char-background-color-foreground-color cell
  check equal?: ch, char a
  check equal?: background-color, color red
  check equal?: foreground-color, color bright cyan

check equal?
  cell->datum char-background-color-foreground-color->cell: char a, color red, color bright cyan
  `cell`
    char a
    `background color red
    `foreground color bright cyan
