library
  mica pico
  export
    pico, size
    push-u8
  import
    leo scheme

  define-keywords: size

  define-syntax
    keywords: size
    case
      when
        pico: size n, x, xs, ...
        with
          implicit: pico, mem, sp
          syntax let*
            with
              mem make-bytevector n
              sp n
            x, xs, ...
      when
        push-u8 u8
        with
          implicit: push-u8, mem, sp
          syntax begin
            set! sp fx-1/wraparound sp
            bytevector-u8-set!: mem, sp, u8
