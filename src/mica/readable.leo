library
  mica readable
  export readable
  import mica scheme

  comment todo
    inline all functions in syntax-case
    add nongreedy? property to readable-record

  define-record readable-record
    required
      immutable first-char/eof?-procedure
      immutable read-procedure
    optional:
    options
      constructor make-readable
      predicate readable?
      prefix "readable-"

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

  define-syntax
    readable stx
    lambda
      with lookup?
      syntax-case stx
        keywords
          define
          with
          let
          in
          list
          of
          or
          eof
          nonempty
          fold
          char
          string
          digit
          nonnegative
          integer
          alphabetic
          numeric
          whitespace
          nothing
          anything
          cons
          separated
          append
          first
          prefixed
          suffixed
          wrapped
          passing
          check
          read
          map
          separated
          by
          line
          column
          next
          char=?
          keywords
          rules
          when
          readable
        when
          readable ch
          char? datum ch
          syntax readable char passing partial: char=?, ch
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
            syntax readable id
        when
          readable: id, arg, ...
          and
            keyword? id
            lookup?: syntax id, syntax readable
          with
            lookup?: syntax id, syntax readable
            syntax readable: id, arg, ...
        when
          readable define
            keywords: ks, ...
            rules
              when
                readable: id, params, ...
                bodies, ...
              when
                readable: id*, params*, ...
                bodies*, ...
              ...
          syntax readable define id
            syntax-rules
              keywords: ks, ...
              when
                readable: id, params, ...
                bodies, ...
              when
                readable: id*, params*, ...
                bodies*, ...
              ...
        when
          readable define rules: xs, ...
          syntax readable define
            keywords:
            rules: xs, ...
        when
          readable define id x
          keyword? id
          syntax define-property id readable x
        when
          readable with x
          syntax make-readable
            lambda: with _, true
            lambda
              with: port, line, column
              values: x, line, column
        when
          readable line
          syntax make-readable
            lambda: with _, true
            lambda
              with: port, line, column
              values: line, line, column
        when
          readable column
          syntax make-readable
            lambda: with _, true
            lambda
              with: port, line, column
              values: column, line, column
        when
          readable nothing
          syntax make-readable
            lambda: with _, false
            lambda
              with: port, line, number
              void:
        when
          readable anything
          syntax readable let
            _ readable char or eof
            in readable anything
        when
          readable next char or eof passing test?
          syntax make-readable
            test?
            lambda
              with: port, line, column
              values: peek-char port, line, column
        when
          readable next char passing test?
          syntax readable next char or eof passing and?: not? eof?, test?
        when
          readable char or eof passing test?
          syntax make-readable
            test?
            lambda
              with: port, line, column
              let
                char/eof read-char port
                in call-with-values
                  lambda char/eof-advance: char/eof, line, column
                  lambda
                    with: line, column
                    values: char/eof, line, column
        when
          readable char passing test?
          syntax readable char or eof passing and?: not? eof?, test?
        when
          readable digit
          syntax digit-readable
        when
          readable char or eof
          syntax char/eof-readable
        when
          readable eof
          syntax readable char or eof passing eof?
        when
          readable char
          syntax readable char or eof passing char?
        when
          readable char: xs, ...
          syntax readable char passing partial
            char=?
            char: xs, ...
        when
          readable char=? ch
          syntax readable char passing partial: char=?, ch
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
          readable let: id a, ..., in b
          syntax let-readable: id readable a, ..., in readable b
        when
          readable map: item, procedure
          syntax readable-map: readable item, procedure
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
          readable list: of item, separated by separator
          syntax separated-list-of-readable: readable separator, readable item
        when
          readable nonempty list: of item, separated by separator
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
          readable wrapped: prefix, item, suffix
          syntax readable prefixed
            prefix
            suffixed: item, suffix
        when
          readable read: rd, str
          string? datum str
          syntax readable-read-string: readable rd, str
        when
          readable read: rd, port
          syntax readable-read: readable rd, port
        when
          readable read all: rd, port
          syntax readable-read-all: readable rd, port
        when
          readable:
            check: item, xs, ...
            ...
          syntax begin
            check-readable: readable item, xs, ...
            ...
        when
          readable x
          syntax readable with x

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

  define peek-char/eof-readable
    peek-char/eof?->readable lambda: with _, true

  define char/eof-readable
    char/eof?->readable lambda: with _, true

  define
    char->readable a-char
    readable char passing partial: char=?, a-char

  define
    readable-map: mapped-readable, procedure
    let-readable
      value mapped-readable
      in readable with with: procedure, value

  define digit-readable
    readable-map
      readable char passing char-numeric?
      lambda
        with char
        subtract: char->integer char, char->integer #\0

  define alphabetic-readable
    readable char passing char-alphabetic?

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

  define
    first-of-readable and readables
    switch readables
      when
        _ null?
        readable nothing
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
        readable with null
      else readables let-readable
        item car readables
        items list->readable cdr readables
        in readable with cons: item, items

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
      in readable with cons: car, cdr

  define
    fold-readable: combine, start-readable, item-readable
    let-readable
      start start-readable
      in first-of-readable
        let-readable
          item item-readable
          in fold-readable
            combine
            readable with combine: start, item
            item-readable
        readable with start

  define
    prefixed-readable: prefix-readable, item-readable
    let-readable
      _ prefix-readable
      item item-readable
      in readable with item

  define
    suffixed-readable: item-readable, suffix-readable
    let-readable
      item item-readable
      _ suffix-readable
      in readable with item

  define
    non-empty-separated-list-of-readable: separator-readable, item-readable
    cons-readable
      item-readable
      first-of-readable
        prefixed-readable
          separator-readable
          separated-list-of-readable: separator-readable, item-readable
        readable with null

  define
    separated-list-of-readable: separator-readable, item-readable
    first-of-readable
      cons-readable
        item-readable
        list-of-readable prefixed-readable: separator-readable, item-readable
      readable with null

  define
    list-of-readable: item-readable
    readable-map
      fold-readable
        lambda
          with: folded, item
          cons: item, folded
        readable with null
        item-readable
      reverse

  define
    non-empty-list-of-readable: readable
    cons-readable
      readable
      list-of-readable readable

  define string-readable
    readable-map
      list-of-readable readable char
      list->string

  define
    char?->string-readable char?
    readable-map
      list-of-readable readable char passing char?
      list->string

  define
    char?->non-empty-string-readable char?
    readable-map
      non-empty-list-of-readable readable char passing char?
      list->string

  define-syntax
    keywords: fails, reads, for, as
    rules
      when
        check-readable readable
        with void
      when
        check-readable
          readable
          reads: string, as out
          xs, ...
        begin
          check equal?
            readable-read-all: readable, open-input-string string
            out
          check-readable: readable, xs, ...
      when
        check-readable
          readable
          fails for: string, ...
          xs, ...
        begin
          begin
            check raises readable-read-all: readable, open-input-string string
            ...
          check-readable: readable, xs, ...
