import
  leo scheme
  mica buffer

check record-type-descriptor? buffer-type

check equal?
  make-empty-buffer:
  make-buffer: "", 0, 0, true

let
  test-buffer make-buffer: "start____end", 4, 5, true
  in
    check equal?: buffer-string test-buffer, "start____end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 4
    check equal?: buffer-position test-buffer, 5
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9

    buffer-slack-change!: test-buffer, 7

    check equal?: buffer-string test-buffer, "start_______end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 7
    check equal?: buffer-position test-buffer, 5
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 12

let
  test-buffer make-buffer: "start____end", 4, 9, false
  in
    check equal?: buffer-string test-buffer, "start____end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 4
    check equal?: buffer-position test-buffer, 9
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 9

    buffer-slack-change!: test-buffer, 7

    check equal?: buffer-string test-buffer, "start_______end"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 7
    check equal?: buffer-position test-buffer, 12
    check equal?: buffer-head-length test-buffer, 5
    check equal?: buffer-tail-length test-buffer, 3
    check equal?: buffer-slack-start-position test-buffer, 5
    check equal?: buffer-slack-end-position test-buffer, 12

let
  test-buffer with make-empty-buffer
  in
    buffer-insert!: test-buffer, "Hello!"

    check equal?: buffer-string test-buffer, "Hello!__"
    check equal?: buffer-length test-buffer, 6
    check equal?: buffer-slack test-buffer, 2
    check equal?: buffer-position test-buffer, 6
    check equal?: buffer-forward? test-buffer, true
    check equal?: buffer-head-length test-buffer, 6
    check equal?: buffer-tail-length test-buffer, 0
    check equal?: buffer-slack-start-position test-buffer, 6
    check equal?: buffer-slack-end-position test-buffer, 8

    buffer-insert!: test-buffer, "!!"

    check equal?: buffer-string test-buffer, "Hello!!!"
    check equal?: buffer-length test-buffer, 8
    check equal?: buffer-slack test-buffer, 0
    check equal?: buffer-position test-buffer, 8
    check equal?: buffer-forward? test-buffer, true
    check equal?: buffer-head-length test-buffer, 8
    check equal?: buffer-tail-length test-buffer, 0
    check equal?: buffer-slack-start-position test-buffer, 8
    check equal?: buffer-slack-end-position test-buffer, 8

    buffer-insert!: test-buffer, "!"

    check equal?: buffer-string test-buffer, "Hello!!!!_______"
    check equal?: buffer-length test-buffer, 9
    check equal?: buffer-slack test-buffer, 7
    check equal?: buffer-position test-buffer, 9
    check equal?: buffer-forward? test-buffer, true
    check equal?: buffer-head-length test-buffer, 9
    check equal?: buffer-tail-length test-buffer, 0
    check equal?: buffer-slack-start-position test-buffer, 9
    check equal?: buffer-slack-end-position test-buffer, 16
