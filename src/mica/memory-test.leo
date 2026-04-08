import
  leo scheme
  mica memory

define size fx*: 1024, 1024
define address foreign-alloc size
dynamic-wind
  lambda void:
  lambda memory-fill!: address, size, 255
  lambda foreign-free address
