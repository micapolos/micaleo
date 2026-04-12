library
  mica qualifier
  export
    qualifier?
    define-qualifier?
    define-qualifier
    define-qualifiers
  import leo scheme

  define-syntax
    qualifier? stx
    lambda
      with lookup?
      syntax-case
        stx
        when
          qualifier? id
          identifier? syntax id
          datum->syntax
            syntax id
            not-false? lookup?: syntax id, syntax qualifier?

  define-syntax rules
    when
      define-qualifier? id
      define-property id qualifier? #t
    when
      define-qualifier id
      begin
        define-keyword id
        define-qualifier? id
    when
      define-qualifiers: id, ...
      begin: define-qualifier id, ...
