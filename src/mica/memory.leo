library
  mica memory
  export
    memory-clear!
    memory-fill!
  import leo scheme

  define
    memory-clear!: address, length
    memory-fill!: address, length, 0

  define
    memory-fill!: address, length, u8
    when
      not fxzero? length
      foreign-set!: 'unsigned-8, address, 0, u8
      memory-fill!: fx1+ address, fx1- length, u8

