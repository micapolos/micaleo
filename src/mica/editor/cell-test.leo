import
  leo scheme
  mica editor cell

let*-values
  with
    with
      values cell
      char-bg-fg->cell: char a, 1, 6
    with
      values: ch, bg, fg
      cell->char-bg-fg cell
  check equal?: ch, char a
  check equal?: bg, 1
  check equal?: fg, 6
