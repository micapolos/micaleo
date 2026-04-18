import
  mica scheme
  mica readable

readable
  check
    nothing
    fails for: "", "a"

  check
    eof
    reads: "", as eof
    fails for "a"

  check
    char
    reads: "f", as char f
    fails for: "", "foo"

  check
    char or eof
    reads: "", as eof
    reads: "a", as char a
    fails for "ab"

  check
    char passing char-numeric?
    reads: "1", as char 1
    fails for: "", "a", "12"

  check
    digit
    reads: "1", as 1
    fails for: "", "a", "12"

  check
    char a
    reads: "a", as char a
    fails for: "", "b", "ab"

  check
    cons: digit, char !
    reads
      "1!"
      as cons: 1, char !
    fails for: "", "1", "12", "a", "ab"

  check
    map: string, string-length
    reads: "", as 0
    reads: "abc", as 3

  check
    fold: number+digit, digit, digit
    reads: "1", as 1
    reads: "12", as 12
    fails for ""

  check
    nonnegative integer
    reads: "1", as 1
    reads: "12", as 12
    fails for ""

  check
    list of digit
    reads: "", as null
    reads
      "1"
      as list: 1
    reads
      "12"
      as list: 1, 2

  check
    nonempty list of digit
    reads
      "1"
      as list: 1
    reads
      "12"
      as list: 1, 2
    fails for ""

  check
    list
      of nonnegative integer
      separated by ", "
    reads: "", as null
    reads
      "123"
      as list: 123
    reads
      "123, 124"
      as list: 123, 124
    reads
      "123, 124, 125"
      as list: 123, 124, 125

  check
    nonempty list
      of nonnegative integer
      separated by ", "
    reads
      "123"
      as list: 123
    reads
      "123, 124"
      as list: 123, 124
    reads
      "123, 124, 125"
      as list: 123, 124, 125
    fails for ""

  check
    list: digit, "+", char
    reads
      "1+!"
      as list: 1, "+", char !
    fails for: "1+", "1+!a"

  check
    string
    reads: "", as ""
    reads: "123", as "123"

  check
    "123"
    reads: "123", as "123"
    fails for: "12", "124", "1234"

  check
    string of char passing char-numeric?
    reads: "", as ""
    reads: "123", as "123"
    fails for: "abc", "123a"

  check
    nonempty string of char passing char-numeric?
    reads: "123", as "123"
    fails for: "", "abc", "123a"

  check
    prefixed: "- ", nonnegative integer
    reads: "- 123", as 123
    fails for: "", "-", "- ", "- abc", "123"

  check
    suffixed: nonnegative integer, "!"
    reads: "123!", as 123
    fails for: "", "!", "123", "abc!"

  check
    wrapped: "(", nonnegative integer, ")"
    reads: "(123)", as 123
    fails for: "", "()", "(abc)", "123"

  check
    first of:
    fails for: "", "a"

  check
    first of
      prefixed: "number ", nonnegative integer
      prefixed: "word ", alphabetic string
    reads: "number 123", as 123
    reads: "word abc", as "abc"

  check
    let
      first-integer nonnegative integer
      unused " + "
      second-integer nonnegative integer
      unused "!"
      in add: first-integer, second-integer
    reads: "10 + 20!", as 30
    fails for "10 - 20!"

  check
    let
      first-integer nonnegative integer
      colon-line line
      colon-column column
      unused ":"
      second-integer nonnegative integer
      in `we have`
        first-integer
        second-integer
        `and colon at
          line` colon-line
          column` colon-column
    reads
      "10:20"
      as `we have
        10
        20
        and colon at: line 1, column 3
