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

  comment can we remove: variable, abstraction-type?
  comment it seems that annotated can handle it all

  define-data*
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
    let*
      with
        ided syntax named
        id syntax name
        id? identifier-append: id, id, syntax ?
        ided? identifier-append: id, ided, syntax ?
        make-ided identifier-append: id, syntax make, syntax -, ided
        make-native-ided identifier-append: id, syntax make, syntax -, syntax native, syntax -, ided
        ided-id identifier-append: id, ided, syntax -, id
        ided-ref identifier-append: id, ided, syntax -, syntax ref
      quasisyntax begin
        define
          : unsyntax ided?, term
          switch? term when
            annotated annotated?
            switch?
              annotated-annotation annotated
              when
                native native?
                : unsyntax id?, native-ref native

        define
          : unsyntax ided-id, term
          native-ref annotated-annotation term

        define
          : unsyntax ided-ref, term
          annotated-ref term

        define
          : unsyntax make-ided, unsyntax id, term
          make-annotated
            make-native unsyntax id
            term

        define
          : unsyntax make-native-ided, unsyntax id
          : unsyntax make-ided, unsyntax id, make-native unsyntax id

  define-syntax rules when
    define-terms: named name, ...
    begin: define-term named name, ...
