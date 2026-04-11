library
  mica typed mico
  export
    define-type
    define-types

    mico
  import
    mica typed base
    mica typed compile
    mica typed type

  comment simple low-level language inspired by c

  define-syntax
    when
      define-type id t
      define-property id type syntax t
    when
      define-types: ids ts, ...
      begin: define-type ids ts, ...

  meta define
    compile?: lookup?, stx
    syntax-case
      stx
      when
        b
        boolean? datum b
        syntax : boolean, b
      when
        fx
        fixnum? datum fx
        syntax : native-int, fx
      when
        fl
        flonum? datum fl
        syntax : native-float, fl
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

  meta define
    type<=?: a, b
    free-syntax=?: a, b

  define-syntax
    mico stx
    lambda
      with lookup?
      syntax-case
        stx
        when
          mico x
          valueof compile
            partial: compile?, lookup?
            syntax x
