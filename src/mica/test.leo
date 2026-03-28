library
  mica test
  export: test-path, test
  import
    mica let
    except: let, from leo scheme
    keyword

  define-syntax
    when
      test-path id
      keyword? id
      string-append
        symbol->string 'id
        "-test.leo"
    when
      test-path id x
      keyword? id
      string-append
        symbol->string 'id
        "/"
        test-path x
    when
      test x
      begin
        write 'testing x
        load test-path x
