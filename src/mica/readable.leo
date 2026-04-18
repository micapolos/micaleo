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
  import
    mica scheme

  define-data readable
    first-char/eof?-procedure
    read-procedure

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

  define readable-char/eof make-readable
    lambda: with _, true
    lambda
      with: port, line, column
      switch
        read-char port
        when
          eof eof?
          values: eof, line, column
        when
          newline char-newline?
          values
            newline
            fx+: line, 1
            1
        else char values
          char
          line
          fx+: column, 1

  define-syntax
    keywords: in
    rules
      when
        let-readable in x
        x
      when
        let-readable
          id r
          in x
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
                in readable-read: x, port, line, column

  define readable-char
    let-readable
      char/eof readable-char/eof
      in switch char/eof
        when: eof eof?, error `eof
        else char readable-with char

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
