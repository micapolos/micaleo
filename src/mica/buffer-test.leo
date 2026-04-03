import
  leo scheme
  mica buffer

check equal?
  with empty-buffer
  buffer: box "", box 0, box 0, box #t

let
  test-buffer buffer
    box "start....end"
    box 4
    box 5
    box #t
  in
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9

let
  test-buffer buffer
    box "start....end"
    box 4
    box 9
    box #f
  in
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9
