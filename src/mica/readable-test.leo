import
  mica scheme
  mica readable

check-readable
  readable nothing
  cases
    error ""
    error "a"

check-readable
  readable char/eof
  cases
    ok: "", eof
    ok: "a", #\a
    error "ab"

check-readable
  readable eof
  cases
    ok: "", eof
    error "a"

check-readable
  readable char
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
  readable digit
  cases
    ok: "1", 1
    error ""
    error "a"
    error "12"

check-readable
  readable #\a
  cases
    ok: "a", char a
    error ""
    error "b"
    error "ab"

check-readable
  readable cons: digit, #\!
  cases
    ok
      "1!"
      cons: 1, char !
    error ""
    error "1"
    error "12"
    error "a"
    error "ab"

check-readable
  readable fold: number+digit, digit, digit
  cases
    error ""
    ok: "1", 1
    ok: "12", 12

check-readable
  readable nonnegative integer
  cases
    error ""
    ok: "1", 1
    ok: "12", 12

check-readable
  readable list of digit
  cases
    ok: "", null
    ok
      "1"
      list: 1
    ok
      "12"
      list: 1, 2

check-readable
  readable nonempty list of digit
  cases
    error ""
    ok
      "1"
      list: 1
    ok
      "12"
      list: 1, 2

check-readable
  readable separated list of: ", ", nonnegative integer
  cases
    ok: "", null
    ok
      "123"
      list: 123
    ok
      "123, 124"
      list: 123, 124
    ok
      "123, 124, 125"
      list: 123, 124, 125

check-readable
  readable nonempty separated list of: ", ", nonnegative integer
  cases
    error ""
    ok
      "123"
      list: 123
    ok
      "123, 124"
      list: 123, 124
    ok
      "123, 124, 125"
      list: 123, 124, 125

check-readable
  readable list: digit, "+", char
  cases
    ok
      "1+!"
      list: 1, "+", char !
    error "1+"
    error "1+!a"

check-readable
  list->readable list: digit-readable, alphabetic-readable, char-readable
  cases
    ok
      "1a!"
      list: 1, char a, char !
    error "1a"
    error "1a!a"

check-readable
  string-readable
  cases
    ok: "", ""
    ok: "123", "123"

check-readable
  readable string
  cases
    ok: "", ""
    ok: "123", "123"

check-readable
  string->readable "123"
  cases
    ok: "123", "123"
    error "12"
    error "124"
    error "1234"

check-readable
  readable "123"
  cases
    ok: "123", "123"
    error "12"
    error "124"
    error "1234"

check-readable
  char?->string-readable char-numeric?
  cases
    ok: "", ""
    ok: "123", "123"
    error "abc"
    error "123a"

check-readable
  char?->non-empty-string-readable char-numeric?
  cases
    ok: "123", "123"
    error ""
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
