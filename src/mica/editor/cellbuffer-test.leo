import
  leo scheme
  mica editor color
  mica editor cell
  mica editor cellbuffer
  mica editor bytebuffer

let
  with cellbuffer with make-empty-cellbuffer

  check equal?: cellbuffer-length cellbuffer, 0
  check equal?: cellbuffer->string cellbuffer, ""
  check equal?
    cellbuffer->background-color-vector cellbuffer
    vector:
  check equal?
    cellbuffer->foreground-color-vector cellbuffer
    vector:

  cellbuffer-insert-cell!
    cellbuffer
    cell
      char a
      background color red
      foreground color cyan

  check equal?: cellbuffer-length cellbuffer, 1
  check equal?: cellbuffer->string cellbuffer, "a"
  check equal?
    cellbuffer->background-color-vector cellbuffer
    vector
      color red
  check equal?
    cellbuffer->foreground-color-vector cellbuffer
    vector
      color cyan

  cellbuffer-insert-cell!
    cellbuffer
    cell
      char Z
      background color blue
      foreground color yellow

  check equal?: cellbuffer-length cellbuffer, 2
  check equal?: cellbuffer->string cellbuffer, "aZ"
  check equal?
    cellbuffer->background-color-vector cellbuffer
    vector
      color red
      color blue
  check equal?
    cellbuffer->foreground-color-vector cellbuffer
    vector
      color cyan
      color yellow

  check equal?
    cellbuffer-current-cell cellbuffer
    cell
      char Z
      background color blue
      foreground color yellow
