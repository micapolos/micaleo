library
  mica mem
  export
    mem-init
    mem-size
    mem-used
    mem-available
    mem-alloc
    mem-free
    mem-u8-ref
    mem-u8-set!
    mem-u16-ref
    mem-u16-set!
    mem-u32-ref
    mem-u32-set!
  import
    leo scheme

  define-syntax mem identifier-syntax
    virtual-register 0
    v set-virtual-register!: 0, v

  define-syntax mem-top identifier-syntax
    virtual-register 1
    v set-virtual-register!: 1, v

  define-syntax rules
    when
      mem-init size
      let
        with n size
        set! mem make-bytevector n
        set! mem-top 0
    when
      mem-size
      bytevector-length mem
    when
      mem-used
      mem-top
    when
      mem-available
      fx-/wraparound: mem-size, mem-top
    when
      mem-alloc size
      let
        with addr mem-top
        set! mem-top fx+/wraparound: mem-top, size
        addr
    when
      mem-free addr
      set! mem-top addr
    when
      mem-u8-set!: addr, u8
      bytevector-u8-set!: mem, addr, u8
    when
      mem-u8-ref addr
      bytevector-u8-ref: mem, addr
    when
      mem-u16-set!: addr, u16
      bytevector-u16-native-set!: mem, addr, u16
    when
      mem-u16-ref addr
      bytevector-u16-native-ref: mem, addr
    when
      mem-u32-set!: addr, u32
      bytevector-u16-native-set!: mem, addr, u32
    when
      mem-u32-ref addr
      bytevector-u32-native-ref: mem, addr
