import
  leo scheme
  mica port

check equal?
  call-with-string-output-port lambda
    with output-port
    get/put-until
      open-input-string "123a456"
      output-port
      char-alphabetic?
  "123a"
