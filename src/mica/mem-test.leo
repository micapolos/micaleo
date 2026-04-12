import
  leo scheme
  mica mem

mem-init 16

check fx=: mem-size, 16
check fx=: mem-used, 0
check fx=: mem-available, 16

mem-u8-set!: 0, 12
check fx=: mem-u8-ref 0, 12

mem-u8-set!: 1, 24
check fx=: mem-u8-ref 0, 12
check fx=: mem-u8-ref 1, 24

mem-u8-set!: 0, 36
check fx=: mem-u8-ref 0, 36
check fx=: mem-u8-ref 1, 24

mem-u16-set!: 0, 1234
check fx=: mem-u16-ref 0, 1234
check not fx=: mem-u8-ref 0, 0
check not fx=: mem-u8-ref 1, 0

check raises mem-u16-ref 1
check raises mem-u16-set!: 1, 1234

let
  with addr mem-alloc 4
  check fx=: addr, 0
  check fx=: mem-size, 16
  check fx=: mem-used, 4
  check fx=: mem-available, 12

let
  with addr mem-alloc 8
  check fx=: addr, 4
  check fx=: mem-size, 16
  check fx=: mem-used, 12
  check fx=: mem-available, 4

let
  with addr mem-alloc 4
  check fx=: addr, 12
  check fx=: mem-size, 16
  check fx=: mem-used, 16
  check fx=: mem-available, 0

mem-free 2
check fx=: mem-size, 16
check fx=: mem-used, 2
check fx=: mem-available, 14
