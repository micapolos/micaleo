library
  mica pico
  export
    pico, size
    push-u8
    pop-u8
    push-u8-u8
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
      when
        pop-u8
        with
          implicit: pop-u8, mem, sp
          syntax let
            with u8 bytevector-u8-ref: mem, sp
            set! sp fx+1/wraparound sp
            u8
      when
        push-u8-u8 u8
        with
          implicit: push-u8-u8, push-u8
          syntax begin: push-u8 u8, push-u8 u8
