import
  mica scheme
  mica readable

call-with-values
  lambda readable-read
    readable-char/eof
    open-input-string "foo"
    3, 4
  lambda
    with: char, line, column
    check equal?: char, #\f
    check equal?: line, 3
    check equal?: column, 5
