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
