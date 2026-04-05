library
  mica bytevector
  export
    bytevector-fill-range!
  import
    leo scheme

  define
    bytevector-fill-range!: bytevector, start, end, byte
    when
      <: start, end
      bytevector-u8-set!: bytevector, start, byte
      bytevector-fill-range!
        bytevector
        fx+/wraparound: start, 1
        end
        byte
