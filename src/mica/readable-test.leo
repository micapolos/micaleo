import
  mica scheme
  mica readable

check-readable
  readable-char/eof
  cases
    ok: "", eof
    ok: "f", #\f
    error "foo"

check-readable
  readable-char
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
