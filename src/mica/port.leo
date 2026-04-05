library
  mica port
  export
    get/put-until
  import
    leo scheme
    eof

  define
    get/put-until: input-port, output-port, char-test?
    switch
      get-char input-port
      when
        eof eof?
        void
      else char
        put-char: output-port, char
        unless
          char-test? char
          get/put-until: input-port, output-port, char-test?


