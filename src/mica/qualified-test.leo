import
  leo scheme
  mica qualifier
  mica qualified

define hello-string "Hello"
define my-lucky-number 7

define-qualifiers: my, lucky

check equal?
  qualified hello string
  "Hello"

check equal?
  qualified my lucky number
  7

define-qualifier? string

check equal?
  qualified string append: "foo", "bar"
  "foobar"
