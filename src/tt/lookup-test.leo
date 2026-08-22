import
  leo scheme
  tt lookup

check raises
  with
    empty-lookup
    syntax x

check equal?
  with
    lookup-push: empty-lookup, syntax x, 10
    syntax x
  10

check raises
  with
    lookup-push: empty-lookup, syntax x, 10
    syntax y

check-lookup lookup:

check-lookup
  lookup: x 10, y 20
  x 10, y 20
