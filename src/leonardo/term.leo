library
  leonardo term
  export
    make-native, native?, native-ref
    make-abstraction, abstraction?, abstraction-procedure
    make-abstraction-type, abstraction-type?, abstraction-type-parameter, abstraction-type-procedure
    make-application, application?, application-target, application-argument
    make-variable, variable?, variable-depth
    make-annotated, annotated?, annotated-annotation, annotated-ref
    term-unpeel
    define-term
    define-terms
  import mica scheme

  comment can we remove abstraction-type?
  comment it seems that annotated can handle it all

  define-datas
    native ref
    abstraction procedure
    abstraction-type: parameter, procedure
    application: target, argument
    variable depth
    annotated: annotation, ref

  define
    term-unpeel term
    switch term
      when
        annotated annotated?
        term-unpeel annotated-ref annotated
      else other
        other

  comment
    requires: name?
    defines: make-named, named?, named-name, named-ref, make-native-named
  define-syntax case when
    define-term named name
    with-identifier
      name? keyword-append: name, name, ?
      named? keyword-append: name, named, ?
      make-named keyword-append: name, make, -, named
      make-native-named keyword-append: name, make, -, native, -, named
      named-name keyword-append: name, named, -, name
      named-ref keyword-append: name, named, -, ref
      in syntax begin
        define
          named? term
          switch? term when
            annotated annotated?
            switch?
              annotated-annotation annotated
              when
                native native?
                name? native-ref native
        define
          named-name term
          native-ref annotated-annotation term
        define
          named-ref term
          annotated-ref term
        define
          make-named: name, term
          make-annotated
            make-native name
            term
        define
          make-native-named name
          make-named: name, make-native name

  define-syntax rules when
    define-terms: named name, ...
    begin: define-term named name, ...
