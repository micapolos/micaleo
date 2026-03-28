library
  mica test
  export: test-path, test
  import
    mica let
    except: let, from leo scheme
    keyword

  define-syntax
    when
      test-path id x
      string-append
        symbol->string 'id
        "/"
        test-path x
    when
      test-path id
      string-append
        symbol->string 'id
        "-test.leo"
    when
      test: x, ...
      begin
        begin
          write 'testing x
          load test-path x
        ...
