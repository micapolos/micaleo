import
  mica let
  mica assert
  only: equal?, string-append, from leo scheme

assert equal?
  let
    hello "Hello"
    world "world"
    hello-world string-append: hello, ", ", world
    in string-append: hello-world, "!"
  "Hello, world!"

