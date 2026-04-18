import
  mica scheme
  mica readable

readable
  check
    nothing
    cases
      error ""
      error "a"

  check
    eof
    cases
      ok: "", eof
      error "a"

  check
    char
    cases
      error: ""
      ok: "f", char f
      error "foo"

  check
    char or eof
    cases
      ok: "", eof
      ok: "a", char a
      error "ab"

  check
    char passing char-numeric?
    cases
      ok: "1", char 1
      error ""
      error "a"
      error "12"

  check
    digit
    cases
      ok: "1", 1
      error ""
      error "a"
      error "12"

  check
    char a
    cases
      ok: "a", char a
      error ""
      error "b"
      error "ab"

  check
    cons: digit, char !
    cases
      ok
        "1!"
        cons: 1, char !
      error ""
      error "1"
      error "12"
      error "a"
      error "ab"

  check
    map: string, string-length
    cases
      ok: "", 0
      ok: "abc", 3

  check
    fold: number+digit, digit, digit
    cases
      error ""
      ok: "1", 1
      ok: "12", 12

  check
    nonnegative integer
    cases
      error ""
      ok: "1", 1
      ok: "12", 12

  check
    list of digit
    cases
      ok: "", null
      ok
        "1"
        list: 1
      ok
        "12"
        list: 1, 2

  check
    nonempty list of digit
    cases
      error ""
      ok
        "1"
        list: 1
      ok
        "12"
        list: 1, 2


  check
    separated list of: ", ", nonnegative integer
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

  check
    nonempty separated list of: ", ", nonnegative integer
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

  check
    list: digit, "+", char
    cases
      ok
        "1+!"
        list: 1, "+", char !
      error "1+"
      error "1+!a"

  check
    string
    cases
      ok: "", ""
      ok: "123", "123"

  check
    "123"
    cases
      ok: "123", "123"
      error "12"
      error "124"
      error "1234"

  check
    string of char passing char-numeric?
    cases
      ok: "", ""
      ok: "123", "123"
      error "abc"
      error "123a"

  check
    nonempty string of char passing char-numeric?
    cases
      ok: "123", "123"
      error ""
      error "abc"
      error "123a"

  check
    prefixed: "- ", nonnegative integer
    cases
      ok: "- 123", 123
      error ""
      error "-"
      error "- "
      error "- abc"
      error "123"

  check
    suffixed: nonnegative integer, "!"
    cases
      ok: "123!", 123
      error ""
      error "!"
      error "123"
      error "abc!"

  check
    first of:
    cases
      error ""
      error "a"

  check
    first of
      prefixed: "number ", nonnegative integer
      prefixed: "word ", alphabetic string
    cases
      ok: "number 123", 123
      ok: "word abc", "abc"

  check
    let
      n1 nonnegative integer
      op " + "
      n2 nonnegative integer
      suffix "!"
      in add: n1, n2
    cases
      ok: "10 + 20!", 30
      error "10 - 20!"
