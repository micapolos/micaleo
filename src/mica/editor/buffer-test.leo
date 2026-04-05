import
  leo scheme
  mica editor buffer

check equal?
  make-empty-buffer:
  make-buffer: "", 0, 0

let
  with buffer make-buffer: "start____end", 5, 9

  check equal?: buffer-string buffer, "start____end"
  check equal?: buffer-slack-start buffer, 5
  check equal?: buffer-slack-end buffer, 9
  check equal?: buffer-length buffer, 8
  check equal?: buffer-slack-length buffer, 4
  check equal?: buffer-head-length buffer, 5
  check equal?: buffer-tail-length buffer, 3

let
  with buffer make-buffer: "start....end", 5, 9

  buffer-slack-fill!: buffer, char _

  check equal?: buffer-string buffer, "start____end"
  check equal?: buffer-slack-start buffer, 5
  check equal?: buffer-slack-end buffer, 9

let
  with buffer make-buffer: "start____end", 5, 9
  buffer-resize!: buffer, 15
  buffer-slack-fill!: buffer, char _

  check equal?: buffer-string buffer, "start_______end"
  check equal?: buffer-slack-start buffer, 5
  check equal?: buffer-slack-end buffer, 12

let
  with buffer with make-empty-buffer

  buffer-insert!: buffer, "Hello!"
  buffer-slack-fill!: buffer, char _

  check equal?: buffer-string buffer, "Hello!__"
  check equal?: buffer-slack-start buffer, 6
  check equal?: buffer-slack-end buffer, 8

  buffer-insert!: buffer, "!!"
  buffer-slack-fill!: buffer, char _

  check equal?: buffer-string buffer, "Hello!!!"
  check equal?: buffer-slack-start buffer, 8
  check equal?: buffer-slack-end buffer, 8

  buffer-insert!: buffer, "!"
  buffer-slack-fill!: buffer, char _

  check equal?: buffer-string buffer, "Hello!!!!_______"
  check equal?: buffer-slack-start buffer, 9
  check equal?: buffer-slack-end buffer, 16
