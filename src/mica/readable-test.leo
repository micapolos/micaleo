import
  mica scheme
  mica readable

readable
  check
    nothing
    cases
      fails ""
      fails "a"

  check
    eof
    cases
      reads: "", eof
      fails "a"

  check
    char
    cases
      fails ""
      reads: "f", char f
      fails "foo"

  check
    char or eof
    cases
      reads: "", eof
      reads: "a", char a
      fails "ab"

  check
    char passing char-numeric?
    cases
      reads: "1", char 1
      fails ""
      fails "a"
      fails "12"

  check
    digit
    cases
      reads: "1", 1
      fails ""
      fails "a"
      fails "12"

  check
    char a
    cases
      reads: "a", char a
      fails ""
      fails "b"
      fails "ab"

  check
    cons: digit, char !
    cases
      reads
        "1!"
        cons: 1, char !
      fails ""
      fails "1"
      fails "12"
      fails "a"
      fails "ab"

  check
    map: string, string-length
    cases
      reads: "", 0
      reads: "abc", 3

  check
    fold: number+digit, digit, digit
    cases
      fails ""
      reads: "1", 1
      reads: "12", 12

  check
    nonnegative integer
    cases
      fails ""
      reads: "1", 1
      reads: "12", 12

  check
    list of digit
    cases
      reads: "", null
      reads
        "1"
        list: 1
      reads
        "12"
        list: 1, 2

  check
    nonempty list of digit
    cases
      fails ""
      reads
        "1"
        list: 1
      reads
        "12"
        list: 1, 2

  check
    separated list of: ", ", nonnegative integer
    cases
      reads: "", null
      reads
        "123"
        list: 123
      reads
        "123, 124"
        list: 123, 124
      reads
        "123, 124, 125"
        list: 123, 124, 125

  check
    nonempty separated list of: ", ", nonnegative integer
    cases
      fails ""
      reads
        "123"
        list: 123
      reads
        "123, 124"
        list: 123, 124
      reads
        "123, 124, 125"
        list: 123, 124, 125

  check
    list: digit, "+", char
    cases
      reads
        "1+!"
        list: 1, "+", char !
      fails "1+"
      fails "1+!a"

  check
    string
    cases
      reads: "", ""
      reads: "123", "123"

  check
    "123"
    cases
      reads: "123", "123"
      fails "12"
      fails "124"
      fails "1234"

  check
    string of char passing char-numeric?
    cases
      reads: "", ""
      reads: "123", "123"
      fails "abc"
      fails "123a"

  check
    nonempty string of char passing char-numeric?
    cases
      reads: "123", "123"
      fails ""
      fails "abc"
      fails "123a"

  check
    prefixed: "- ", nonnegative integer
    cases
      reads: "- 123", 123
      fails ""
      fails "-"
      fails "- "
      fails "- abc"
      fails "123"

  check
    suffixed: nonnegative integer, "!"
    cases
      reads: "123!", 123
      fails ""
      fails "!"
      fails "123"
      fails "abc!"

  check
    first of:
    cases
      fails ""
      fails "a"

  check
    first of
      prefixed: "number ", nonnegative integer
      prefixed: "word ", alphabetic string
    cases
      reads: "number 123", 123
      reads: "word abc", "abc"

  check
    let
      n1 nonnegative integer
      op " + "
      n2 nonnegative integer
      suffix "!"
      in add: n1, n2
    cases
      reads: "10 + 20!", 30
      fails "10 - 20!"
