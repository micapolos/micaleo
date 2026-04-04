import
  leo scheme
  mica current

define syntax current-ms
  make-compile-time-value lambda syntax
    time-second with current-time

define syntax
  current-ref! stx
  lambda
    with lookup
    define lambda
      transform stx
      syntax-case
        stx
        keywords: let, in
        when
          id
          keyword? id
          with lookup syntax id
        when
          let in body
          transform syntax body
        when
          fn: arg, ...
          let
            fn transform syntax fn
            args map
              trasform
              syntax
                : arg, ...
            quasisyntax with
              unsyntax fn
              unsyntax-splicing args
    syntax-case
      stx
      keywords:
      when
        _ body
        transform syntax body

write current-ref! let in current-ms
