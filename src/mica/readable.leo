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
  import
    mica scheme

  define-data readable
    first-char/eof?-procedure
    read-procedure

  define readable-read
    case-lambda
      when
        with: readable, port, line, column
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
      when
        with: readable, port
        readable-read: readable, port, 1, 1

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
        when
          eof eof?
          error `eof
        else char
          make-readable
            lambda: with _, false
            lambda
              with: port, line, column
              error `dupa

  define
    char-readable char
    make-readable
      read-char readable-char
      in if
        char=?: char, read-char
        then char
        else error `unexpected

    let-readable
      char/eof readable-char/eof
      in switch char/eof
        when
          eof eof?
          error `eof
        else char
          make-readable
            lambda: with _, false
            lambda
              with: port, line, column
              error `dupa

