library
  mica memory
  export memory-clear!
  import leo scheme

  define
    memory-clear!: address, length
    when
      not zero? length
      foreign-set!: 'unsigned-8, address, 0, 0
      memory-clear!: fx1+ address, fx1- length

