library
  mica memory
  export
    memory-clear!
    memory-fill!
  import
    leo scheme

  define
    memory-clear!: address, length
    memory-fill!: address, length, 0

  define
    memory-fill!: address, length, u8
    unless
      fxzero? length
      let
        with new-length fx-/wraparound: length, 1
        foreign-set!: 'unsigned-8, address, new-length, u8
        memory-fill!: address, new-length, u8
