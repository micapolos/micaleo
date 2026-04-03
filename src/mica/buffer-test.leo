import
  leo scheme
  mica buffer

check equal?
  with make-empty-buffer
  make-buffer: "", 0, 0, #t

let
  test-buffer make-buffer: "start____end", 4, 5, #t
  in
    check equal?: buffer-string test-buffer, "start____end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 4
    check equal?: buffer-position test-buffer, 5
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9

    buffer-slack-set!: test-buffer, 7

    check equal?: buffer-string test-buffer, "start_______end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 7
    check equal?: buffer-position test-buffer, 5
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 12

let
  test-buffer make-buffer: "start____end", 4, 9, #f
  in
    check equal?: buffer-string test-buffer, "start____end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 4
    check equal?: buffer-position test-buffer, 9
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9

    buffer-slack-set!: test-buffer, 7

    check equal?: buffer-string test-buffer, "start_______end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 7
    check equal?: buffer-position test-buffer, 12
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 12
