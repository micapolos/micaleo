import
  mica scheme
  mica readable

define number-readable
  fold-readable
    number+digit
    digit-readable
    digit-readable

define
  comma-separated-readable readable
  cons-readable
    readable
    list-of-readable prefixed-readable
      string->readable ", "
      readable

print readable-read-string
  comma-separated-readable number-readable
  "123, 124, 125, 127"
