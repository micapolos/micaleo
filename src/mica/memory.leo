library
  mica memory
  export
    memory-clear!
    memory-fill!
  import
    leo scheme

  define
    memory-clear!: address, start-offset, end-offset
    memory-fill!: address, start-offset, end-offset, 0

  define
    memory-fill!: address, start-offset, end-offset, u8
    unless
      fx=?: start-offset, end-offset
      foreign-set!: 'unsigned-8, address, start-offset, u8
      memory-fill!
        address
        fx+/wraparound: start-offset, 1
        end-offset
        u8
