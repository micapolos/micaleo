library
  mica readable
  export
    make-readable
    readable?
    readable-first-char/eof?-procedure
    readable-read-procedure
    readable-read
    readable-char/eof
    readable-char
    let-readable
    check-readable
    char/eof?->readable
    char?->readable
    char->readable
    digit-readable
    alphabetic-readable
    readable-map
    cons-readable
  import
    mica scheme

  define-data readable
    first-char/eof?-procedure
    read-procedure

  define
    char/eof-advance: char/eof, line, column
    switch char/eof
      when
        eof eof?
        values: line, column
      when
        newline char-newline?
        values
          fx+: line, 1
          1
      else char values
        line
        fx+: column, 1

  define
    readable-with value
    make-readable
      lambda: with _, true
      lambda
        with: port, line, column
        values: value, line, column

  define
    readable-read: readable, port, line, column
    switch
      peek-char port
      when
        char readable-first-char/eof?-procedure readable
        with: readable-read-procedure readable, port, line, column
      else other
        error
          `unexpected` other
          `at
            line` line
            column` column

  define
    readable-read-all: readable, port
    call-with-values
      lambda readable-read: readable, port, 1, 1
      lambda
        with: value, line, column
        unless
          port-eof? port
          error `more at: line` line, column` column
        value

  define
    char/eof?->readable char/eof?
    make-readable
      char/eof?
      lambda
        with: port, line, column
        let
          char/eof read-char port
          in call-with-values
            lambda char/eof-advance: char/eof, line, column
            lambda
              with: line, column
              values: char/eof, line, column

  define
    char?->readable char?
    char/eof?->readable and?: not? eof?, char?

  define readable-char/eof
    char/eof?->readable lambda: with _, true

  define
    char->readable char
    char?->readable partial: char=?, char

  define
    readable-map: readable, procedure
    let-readable
      value readable
      in readable-with with: procedure, value

  define digit-readable
    readable-map
      char?->readable char-numeric?
      lambda
        with char
        subtract: char->integer char, char->integer #\0

  define alphabetic-readable
    char?->readable char-alphabetic?

  define-syntax
    keywords: in
    rules
      when
        let-readable in x
        x
      when
        let-readable: id r, binding, ..., in x
        let
          rid r
          in make-readable
            readable-first-char/eof?-procedure rid
            lambda
              with: port, line, column
              let-values
                with
                  values: id, line, column
                  readable-read: rid, port, line, column
                in readable-read
                  let-readable: binding, ..., in x
                  port
                  line
                  column

  define readable-char
    let-readable
      char/eof readable-char/eof
      in switch char/eof
        when: eof eof?, error `eof
        else char readable-with char

  define
    cons-readable: car-readable, cdr-readable
    let-readable
      car car-readable
      cdr cdr-readable
      in readable-with cons: car, cdr

  define-syntax rules
    when
      check-readable-case
        readable
        ok: string, out
      free-keyword? ok
      check equal?
        readable-read-all: readable, open-input-string string
        out
    when
      check-readable-case
        readable
        error string
      free-keyword? error
      check raises readable-read-all: readable, open-input-string string
    when
      check-readable
        readable
        cases: case, ...
      free-keyword? cases
      begin
        check-readable-case: readable, case
        ...
