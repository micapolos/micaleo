library
  mica typed mico
  export
    define-type
    define-types
    mico
  import
    mica typed base
    mica typed compile
    mica typed keywords
  export import mica typed keywords

  comment mico: simple low-level language inspired by c

  define-syntax
    when
      define-type id t
      define-property id type syntax t
    when
      define-types: ids ts, ...
      begin: define-type ids ts, ...

  define-syntax
    mico stx
    lambda
      with lookup?
      syntax-case
        stx
        when
          mico x
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
