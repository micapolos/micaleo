import
  mica test
  mica assert
  except: assert, from leo scheme

assert equal?
  test-path foo
  "foo-test.leo"

assert equal?
  test-path foo bar
  "foo/bar-test.leo"

assert equal?
  test-path foo bar zar
  "foo/bar/zar-test.leo"
