import
  mica scheme
  mica readable

check-readable
  error-readable
  cases
    error ""
    error "a"

check-readable
  char/eof-readable
  cases
    ok: "", eof
    ok: "f", #\f
    error "foo"

check-readable
  char-readable
  cases
    error: ""
    ok: "f", #\f
    error "foo"

check-readable
  char/eof?->readable or?: eof?, char-numeric?
  cases
    ok: "", eof
    ok: "1", #\1
    error "a"
    error "12"

check-readable
  char?->readable char-numeric?
  cases
    ok: "1", #\1
    error ""
    error "a"
    error "12"

check-readable
  digit-readable
  cases
    ok: "1", 1
    error ""
    error "a"
    error "12"

check-readable
  char->readable char a
  cases
    ok: "a", char a
    error ""
    error "b"
    error "ab"

check-readable
  cons-readable: digit-readable, alphabetic-readable
  cases
    ok
      "1a"
      cons: 1, char a
    error ""
    error "1"
    error "12"
    error "a"
    error "ab"

check-readable
  fold-readable
    number+digit
    digit-readable
    digit-readable
  cases
    error ""
    ok: "1", 1
    ok: "12", 12

check-readable
  list-of-readable digit-readable
  cases
    ok: "", null
    ok
      "1"
      list: 1
    ok
      "12"
      list: 1, 2

check-readable
  readable-append: digit-readable, alphabetic-readable, char-readable
  cases
    ok
      "1a!"
      list: 1, char a, char !
    error "1a"
    error "1a!a"

check-readable
  list->readable list: digit-readable, alphabetic-readable, char-readable
  cases
    ok
      "1a!"
      list: 1, char a, char !
    error "1a"
    error "1a!a"

check-readable
  string->readable "123"
  cases
    ok: "123", "123"
    error "12"
    error "124"
    error "1234"

check-readable
  string->readable "123"
  cases
    ok: "123", "123"
    error "12"
    error "124"
    error "1234"

check-readable
  char?->string-readable char-numeric?
  cases
    ok: "123", "123"
    error "abc"
    error "123a"

check-readable
  first-of-readable:
  cases
    error ""
    error "a"

check-readable
  suffixed-readable
    first-of-readable
      prefixed-readable
        string->readable "digits "
        char?->string-readable char-numeric?
      prefixed-readable
        string->readable "letters "
        char?->string-readable char-alphabetic?
    char->readable char !
  cases
    ok: "digits 123!", "123"
    ok: "letters abc!", "abc"
