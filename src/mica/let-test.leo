import
  mica let
  except: let, from leo scheme

check equal?
  let
    hello "Hello"
    world "world"
    hello-world string-append: hello, ", ", world
    in string-append: hello-world, "!"
  "Hello, world!"

check equal?
  let
    with
      values: hello, world
      values: "Hello", "world"
    hello-world string-append: hello, ", ", world
    in string-append: hello-world, "!"
  "Hello, world!"
