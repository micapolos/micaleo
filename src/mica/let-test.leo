import
  mica let
  mica assert
  except: let, assert, from leo scheme

assert equal?
  let
    hello "Hello"
    world "world"
    hello-world string-append: hello, ", ", world
    in string-append: hello-world, "!"
  "Hello, world!"

assert equal?
  let
    with
      values: hello, world
      values: "Hello", "world"
    hello-world string-append: hello, ", ", world
    in string-append: hello-world, "!"
  "Hello, world!"
