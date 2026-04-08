import
  leo scheme
  mica memory

define size *: 1024, 1024, 32
define address foreign-alloc size
dynamic-wind
  lambda void:
  lambda memory-fill!: address, 0, size, 255
  lambda foreign-free address
