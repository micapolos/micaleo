import
  mica scheme
  mica readable

readable
  check
    nothing
    fails ""
    fails "a"

  check
    eof
    reads: "", eof
    fails "a"

  check
    char
    fails ""
    reads: "f", char f
    fails "foo"

  check
    char or eof
    reads: "", eof
    reads: "a", char a
    fails "ab"

  check
    char passing char-numeric?
    reads: "1", char 1
    fails ""
    fails "a"
    fails "12"

  check
    digit
    reads: "1", 1
    fails ""
    fails "a"
    fails "12"

  check
    char a
    reads: "a", char a
    fails ""
    fails "b"
    fails "ab"

  check
    cons: digit, char !
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
    reads: "", 0
    reads: "abc", 3

  check
    fold: number+digit, digit, digit
    fails ""
    reads: "1", 1
    reads: "12", 12

  check
    nonnegative integer
    fails ""
    reads: "1", 1
    reads: "12", 12

  check
    list of digit
    reads: "", null
    reads
      "1"
      list: 1
    reads
      "12"
      list: 1, 2

  check
    nonempty list of digit
    fails ""
    reads
      "1"
      list: 1
    reads
      "12"
      list: 1, 2

  check
    separated list of: ", ", nonnegative integer
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
    reads
      "1+!"
      list: 1, "+", char !
    fails "1+"
    fails "1+!a"

  check
    string
    reads: "", ""
    reads: "123", "123"

  check
    "123"
    reads: "123", "123"
    fails "12"
    fails "124"
    fails "1234"

  check
    string of char passing char-numeric?
    reads: "", ""
    reads: "123", "123"
    fails "abc"
    fails "123a"

  check
    nonempty string of char passing char-numeric?
    reads: "123", "123"
    fails ""
    fails "abc"
    fails "123a"

  check
    prefixed: "- ", nonnegative integer
    reads: "- 123", 123
    fails ""
    fails "-"
    fails "- "
    fails "- abc"
    fails "123"

  check
    suffixed: nonnegative integer, "!"
    reads: "123!", 123
    fails ""
    fails "!"
    fails "123"
    fails "abc!"

  check
    first of:
    fails ""
    fails "a"

  check
    first of
      prefixed: "number ", nonnegative integer
      prefixed: "word ", alphabetic string
    reads: "number 123", 123
    reads: "word abc", "abc"

  check
    let
      n1 nonnegative integer
      op " + "
      n2 nonnegative integer
      suffix "!"
      in add: n1, n2
    reads: "10 + 20!", 30
    fails "10 - 20!"
