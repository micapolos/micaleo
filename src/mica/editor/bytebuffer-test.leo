import
  leo scheme
  mica editor bytebuffer

check equal?
  make-empty-bytebuffer:
  make-bytebuffer
    bytevector:
    0, 0

let
  with bytebuffer make-bytebuffer
    bytevector: 1, 2, 3, 4, 5, 0, 0, 0, 0, 10, 11, 12
    5, 9

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 0, 0, 0, 0, 10, 11, 12
  check equal?: bytebuffer-slack-start bytebuffer, 5
  check equal?: bytebuffer-slack-end bytebuffer, 9
  check equal?: bytebuffer-length bytebuffer, 8
  check equal?: bytebuffer-slack-length bytebuffer, 4
  check equal?: bytebuffer-head-length bytebuffer, 5
  check equal?: bytebuffer-tail-length bytebuffer, 3

let
  with bytebuffer make-bytebuffer
    bytevector: 1, 2, 3, 4, 5, 0, 0, 0, 0, 10, 11, 12
    5, 9

  bytebuffer-slack-fill!: bytebuffer, 255

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 255, 255, 255, 255, 10, 11, 12
  check equal?: bytebuffer-slack-start bytebuffer, 5
  check equal?: bytebuffer-slack-end bytebuffer, 9

let
  with bytebuffer make-bytebuffer
    bytevector: 1, 2, 3, 4, 5, 0, 0, 0, 0, 10, 11, 12
    5, 9
  bytebuffer-resize!: bytebuffer, 15
  bytebuffer-slack-fill!: bytebuffer, 0

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 10, 11, 12
  check equal?: bytebuffer-slack-start bytebuffer, 5
  check equal?: bytebuffer-slack-end bytebuffer, 12

let
  with bytebuffer with make-empty-bytebuffer

  bytebuffer-insert!
    bytebuffer
    bytevector: 1, 2, 3, 4, 5, 6

  bytebuffer-slack-fill!: bytebuffer, 0

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 6, 0, 0
  check equal?: bytebuffer-slack-start bytebuffer, 6
  check equal?: bytebuffer-slack-end bytebuffer, 8

  bytebuffer-insert!
    bytebuffer
    bytevector: 7, 8

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 6, 7, 8
  check equal?: bytebuffer-slack-start bytebuffer, 8
  check equal?: bytebuffer-slack-end bytebuffer, 8

  bytebuffer-insert!
    bytebuffer
    bytevector: 9
  bytebuffer-slack-fill!: bytebuffer, 0

  check equal?
    bytebuffer-bytevector bytebuffer
    bytevector: 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0
  check equal?: bytebuffer-slack-start bytebuffer, 9
  check equal?: bytebuffer-slack-end bytebuffer, 16
