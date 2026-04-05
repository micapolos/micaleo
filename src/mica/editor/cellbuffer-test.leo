import
  leo scheme
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
    char-background-color-foreground-color->cell: char a, 1, 6

  check equal?: cellbuffer-length cellbuffer, 1
  check equal?: cellbuffer->string cellbuffer, "a"
  check equal?
    cellbuffer->background-color-vector cellbuffer
    vector: 1
  check equal?
    cellbuffer->foreground-color-vector cellbuffer
    vector: 6

  cellbuffer-insert-cell!
    cellbuffer
    char-background-color-foreground-color->cell: char Z, 7, 2

  check equal?: cellbuffer-length cellbuffer, 2
  check equal?: cellbuffer->string cellbuffer, "aZ"
  check equal?
    cellbuffer->background-color-vector cellbuffer
    vector: 1, 7
  check equal?
    cellbuffer->foreground-color-vector cellbuffer
    vector: 6, 2

  check equal?
    cellbuffer-current-cell cellbuffer
    char-background-color-foreground-color->cell: char Z, 7, 2
