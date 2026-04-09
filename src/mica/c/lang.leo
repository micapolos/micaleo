library
  mica c lang
  export
    define-type
    define-types
    lang
  import
    mica c base
    mica c compile
    mica c keywords
  export import mica c keywords

  define-syntax
    when
      define-type id t
      define-property id type syntax t
    when
      define-types: ids ts, ...
      begin: define-type ids ts, ...

  define-syntax
    lang stx
    lambda
      with lookup?
      syntax-case
        stx
        when
          lang x
          valueof compile
            lambda
              with stx
              syntax-case
                stx
                when
                  b
                  boolean? datum b
                  syntax : boolean, b
                when
                  fx
                  fixnum? datum fx
                  syntax : native overflowing integer, fx
                when
                  fl
                  flonum? datum fl
                  syntax : native inexact float, fl
                when
                  ch
                  char? datum ch
                  syntax : char, ch
                when
                  s
                  string? datum s
                  syntax : string, s
                when
                  id
                  keyword? id
                  let
                    with type? lookup?: stx, syntax type
                    and
                      type?
                      quasisyntax : unsyntax type?, id
                when: _, #f
            free-syntax=?
            syntax x
