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

  define-syntax rules
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
