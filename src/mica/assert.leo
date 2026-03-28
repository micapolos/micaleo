library
  mica assert
  export assert
  import
    except: assert, from leo scheme
    only: check, from micascheme

  define-syntax
    when
      assert x
      check x
