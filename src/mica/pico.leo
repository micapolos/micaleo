library
  mica pico
  export
    push-u8
  import
    leo scheme

  define-syntax case
    when
      push-u8 u8
      with
        implicit: push-u8, mem, sp
        syntax begin
          set! sp fx-1/wraparound sp
          bytevector-u8-set!: mem, sp, u8
