import
  mica scheme
  mica readable

define comma-separator-readable
  string->readable ", "

define number-readable
  fold-readable
    number+digit
    digit-readable
    digit-readable

define word-readable
  char?->non-empty-string-readable char-alphabetic?

print readable-read-string
  separated-list-of-readable
    comma-separator-readable
    number-readable
  "123, 124, 125, 127"
