library
  mica qualifier
  export
    qualifier?
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
          keyword? id
          datum->syntax
            syntax qualifier?
            not-false?
              guard
                raised
                  when
                    syntax-violation? raised
                    syntax-error
                      syntax id
                      'undefined keyword
                lookup?: syntax id, syntax qualifier?
        when
          qualifier? other
          syntax-error
            syntax other
            'expected keyword

  define-syntax rules when
    define-qualifier id
    define-property id qualifier? #t

  define-syntax rules when
    define-qualifiers: id, ...
    begin: define-qualifier id, ...
