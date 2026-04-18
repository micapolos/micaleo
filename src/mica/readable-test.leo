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
  first-of-readable:
  cases
    error ""
    error "a"

check-readable
  first-of-readable: digit-readable, alphabetic-readable, char->readable char ?
  cases
    ok: "1", 1
    ok: "a", char a
    ok: "?", char ?
    error: " "
    error: "$"
    error: "11"
    error: "aa"
