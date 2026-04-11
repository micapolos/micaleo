import
  leo scheme
  mica pico

pico
  size 1024
  push-u8 255
  push-u8-u8 12
  check equal?: pop-u8, 12
  check equal?: pop-u8, 12
  check equal?: pop-u8, 255
