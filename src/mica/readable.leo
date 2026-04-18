library
  mica readable
  export
    readable
    make-readable
    readable?
    readable-first-char/eof?-procedure
    readable-read-procedure
    readable-first-char/eof?
    readable-read
    readable-read-all
    readable-read-string
    peek-char/eof-readable
    peek-char-readable
    char/eof-readable
    char-readable
    string-readable
    error-readable
    let-readable
    check-readable
    peek-char/eof?->readable
    peek-char?->readable
    char/eof?->readable
    char?->readable
    char?->string-readable
    char?->non-empty-string-readable
    char->readable
    string->readable
    digit-readable
    alphabetic-readable
    readable-map
    cons-readable
    first-of-readable
    fold-readable
    list-of-readable
    non-empty-list-of-readable
    separated-list-of-readable
    non-empty-separated-list-of-readable
    prefixed-readable
    suffixed-readable
    list->readable
    readable-append
  import
    mica scheme

  define-record readable-record
    with
      immutable first-char/eof?-procedure
      immutable read-procedure
    with:
    with
      constructor make-readable
      predicate readable?
      prefix "readable-"

  define-syntax
    readable stx
    lambda
      with lookup?
      syntax-case stx
        keywords
          with
          let*
          in
          list
          of
          eof
          nonempty
          fold
          char/eof
          char
          string
          digit
          nonnegative
          integer
          alphabetic
          numeric
          whitespace
          nothing
          cons
          separated
          append
          first
          prefixed
          suffixed
          passing
          check
        when
          readable ch
          char? datum ch
          syntax char->readable ch
        when
          readable s
          string? datum s
          syntax string->readable s
        when
          readable id
          and
            keyword? id
            lookup?: syntax id, syntax readable
          with
            lookup?: syntax id, syntax readable
            syntax id
        when
          readable: id, arg, ...
          and
            keyword? id
            lookup?: syntax id, syntax readable
          with
            lookup?: syntax id, syntax readable
            syntax : id, arg, ...
        when
          readable with x
          syntax readable-with x
        when
          readable nothing
          syntax error-readable
        when
          readable digit
          syntax digit-readable
        when
          readable char/eof
          syntax char/eof-readable
        when
          readable eof
          syntax char/eof?->readable eof?
        when
          readable char
          syntax char-readable
        when
          readable char/eof passing test?
          syntax char/eof?->readable test?
        when
          readable char passing test?
          syntax char?->readable test?
        when
          readable string
          syntax string-readable
        when
          readable string of char passing test?
          syntax char?->string-readable test?
        when
          readable nonempty string of char passing test?
          syntax char?->non-empty-string-readable test?
        when
          readable alphabetic string
          syntax char?->string-readable char-alphabetic?
        when
          readable numeric string
          syntax char?->string-readable char-numeric?
        when
          readable whitespace string
          syntax char?->string-readable char-whitespace?
        when
          readable nonnegative integer
          syntax fold-readable: number+digit, readable digit, readable digit
        when
          readable let*: id a, ..., in b
          syntax let-readable: id readable a, ..., in readable b
        when
          readable fold: combine, start, item
          syntax fold-readable: combine, readable start, readable item
        when
          readable list of item
          syntax list-of-readable readable item
        when
          readable nonempty list of item
          syntax non-empty-list-of-readable readable item
        when
          readable cons: car, cdr
          syntax cons-readable: readable car, readable cdr
        when
          readable separated list of: separator, item
          syntax separated-list-of-readable: readable separator, readable item
        when
          readable nonempty separated list of: separator, item
          syntax non-empty-separated-list-of-readable: readable separator, readable item
        when
          readable list: item, ...
          syntax readable-append: readable item, ...
        when
          readable first of: item, ...
          syntax first-of-readable: readable item, ...
        when
          readable prefixed: prefix, item
          syntax prefixed-readable: readable prefix, readable item
        when
          readable suffixed: item, suffix
          syntax suffixed-readable: readable item, readable suffix
        when
          readable:
            check: item, cases
            ...
          syntax begin
            check-readable: readable item, cases
            ...

  define
    char/eof-advance: char/eof, line, column
    switch char/eof
      when
        eof eof?
        values: line, column
      when
        newline char-newline?
        values
          fx+: line, 1
          1
      else char values
        line
        fx+: column, 1

  define
    readable-with value
    make-readable
      lambda: with _, true
      lambda
        with: port, line, column
        values: value, line, column

  define
    lazy-readable: readable
    make-readable
      lambda
        with char/eof
        readable-first-char/eof?: readable, char/eof
      lambda
        with: port, line, number
        readable-read: readable, port, line, number

  define error-readable
    make-readable
      lambda: with _, false
      lambda
        with: port, line, number
        void:

  define
    readable-read: readable, port, line, column
    switch
      peek-char port
      when
        char readable-first-char/eof?-procedure readable
        with: readable-read-procedure readable, port, line, column
      else other
        error
          `unexpected` other
          `at
            line` line
            column` column

  define
    readable-first-char/eof?: readable, char/eof
    with: readable-first-char/eof?-procedure readable, char/eof

  define
    readable-read-all: readable, port
    call-with-values
      lambda readable-read: readable, port, 1, 1
      lambda
        with: value, line, column
        unless
          port-eof? port
          error `more at: line` line, column` column
        value

  define
    readable-read-string: readable, string
    readable-read-all: readable, open-input-string string

  define
    peek-char/eof?->readable char/eof?
    make-readable
      char/eof?
      lambda
        with: port, line, column
        values: peek-char port, line, column

  define
    peek-char?->readable char?
    peek-char/eof?->readable and?: not? eof?, char?

  define
    char/eof?->readable char/eof?
    make-readable
      char/eof?
      lambda
        with: port, line, column
        let
          char/eof read-char port
          in call-with-values
            lambda char/eof-advance: char/eof, line, column
            lambda
              with: line, column
              values: char/eof, line, column

  define
    char?->readable char?
    char/eof?->readable and?: not? eof?, char?

  define peek-char/eof-readable
    peek-char/eof?->readable lambda: with _, true

  define char/eof-readable
    char/eof?->readable lambda: with _, true

  define
    char->readable char
    char?->readable partial: char=?, char

  define
    readable-map: readable, procedure
    let-readable
      value readable
      in readable-with with: procedure, value

  define digit-readable
    readable-map
      char?->readable char-numeric?
      lambda
        with char
        subtract: char->integer char, char->integer #\0

  define alphabetic-readable
    char?->readable char-alphabetic?

  define-syntax
    keywords: in
    rules
      when
        let-readable in x
        x
      when
        let-readable: id r, binding, ..., in x
        let
          rid r
          in make-readable
            readable-first-char/eof?-procedure rid
            lambda
              with: port, line, column
              let-values
                with
                  values: id, line, column
                  readable-read: rid, port, line, column
                in readable-read
                  let-readable: binding, ..., in x
                  port
                  line
                  column

  define char-readable
    char/eof?->readable char?

  define peek-char-readable
    let-readable
      char/eof peek-char/eof-readable
      in switch char/eof
        when: eof eof?, error `eof
        else char readable-with char

  define
    first-of-readable and readables
    switch readables
      when
        _ null?
        error-readable
      else readables
        let
          readable car readables
          readables cdr readables
          in let-readable
            char/eof peek-char/eof-readable
            in cond
              when
                readable-first-char/eof?: readable, char/eof
                readable
              else
                apply: first-of-readable, readables

  define
    list->readable readables
    switch readables
      when
        null null?
        readable-with null
      else readables let-readable
        item car readables
        items list->readable cdr readables
        in readable-with cons: item, items

  define
    readable-append and readables
    list->readable readables

  define
    string->readable string
    readable-map
      list->readable map: char->readable, string->list string
      list->string

  define
    cons-readable: car-readable, cdr-readable
    let-readable
      car car-readable
      cdr cdr-readable
      in readable-with cons: car, cdr

  define
    fold-readable: combine, start-readable, item-readable
    let-readable
      start start-readable
      in first-of-readable
        let-readable
          item item-readable
          in fold-readable
            combine
            readable-with combine: start, item
            item-readable
        readable-with start

  define
    prefixed-readable: prefix-readable, item-readable
    let-readable
      _ prefix-readable
      item item-readable
      in readable-with item

  define
    suffixed-readable: item-readable, suffix-readable
    let-readable
      item item-readable
      _ suffix-readable
      in readable-with item

  define
    non-empty-separated-list-of-readable: separator-readable, item-readable
    cons-readable
      item-readable
      first-of-readable
        prefixed-readable
          separator-readable
          separated-list-of-readable: separator-readable, item-readable
        readable-with null

  define
    separated-list-of-readable: separator-readable, item-readable
    first-of-readable
      cons-readable
        item-readable
        list-of-readable prefixed-readable: separator-readable, item-readable
      readable-with null

  define
    list-of-readable: readable
    readable-map
      fold-readable
        lambda
          with: folded, item
          cons: item, folded
        readable-with null
        readable
      reverse

  define
    non-empty-list-of-readable: readable
    cons-readable
      readable
      list-of-readable readable

  define string-readable
    readable-map
      list-of-readable char-readable
      list->string

  define
    char?->string-readable char?
    readable-map
      list-of-readable char?->readable char?
      list->string

  define
    char?->non-empty-string-readable char?
    readable-map
      non-empty-list-of-readable char?->readable char?
      list->string

  define-syntax rules
    when
      check-readable-case
        readable
        ok: string, out
      free-keyword? ok
      check equal?
        readable-read-all: readable, open-input-string string
        out
    when
      check-readable-case
        readable
        error string
      free-keyword? error
      check raises readable-read-all: readable, open-input-string string
    when
      check-readable
        readable
        cases: case, ...
      free-keyword? cases
      begin
        check-readable-case: readable, case
        ...
