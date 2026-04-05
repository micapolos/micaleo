import
  leo scheme
  mica editor cell

let*-values
  with
    with
      values cell
      char-background-color-foreground-color->cell: char a, 1, 6
    with
      values: ch, background-color, foreground-color
      cell->char-background-color-foreground-color cell
  check equal?: ch, char a
  check equal?: background-color, 1
  check equal?: foreground-color, 6
