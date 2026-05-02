import
  leo scheme
  mica editor color
  mica editor cell

let
  with cell cell
    char a
    background color red
    foreground color bright cyan
  check equal?: cell->char cell, char a
  check equal?: cell->background-color cell, color red
  check equal?: cell->foreground-color cell, color bright cyan

check equal?
  cell->datum cell
    char a
    background color red
    foreground color bright cyan
  'cell'
    char a
    'background color red
    'foreground color bright cyan

check equal?: ftype-sizeof fcell, 4
