library
  mica classifier
  export
    make-classifier
    classifier-transform
  import leo scheme

  define-record classifier with
    noun?-procedure
    verb?-procedure
    adjective?-procedure
    adverb?-procedure
    label?-procedure

  define
    classifier-noun?: classifier, identifier
    with
      classifier-noun?-procedure classifier
      identifier

  define
    classifier-verb?: classifier, identifier
    with
      classifier-verb?-procedure classifier
      identifier

  define
    classifier-adjective?: classifier, identifier
    with
      classifier-adjective?-procedure classifier
      identifier

  define
    classifier-adverb?: classifier, identifier
    with
      classifier-adverb?-procedure classifier
      identifier

  define
    classifier-label?: classifier, identifier
    with
      classifier-label?-procedure classifier
      identifier

  define
    classifier+noun: classifier, noun
    make-classifier
      lambda
        with identifier
        or
          free-identifier=?: identifier, noun
          classifier-adjective?: classifier, noun
      classifier-verb?-procedure classifier
      classifier-adjective?-procedure classifier
      classifier-adverb?-procedure classifier
      classifier-label?-procedure classifier

  define
    classifier+verb: classifier, verb
    make-classifier
      classifier-noun?-procedure classifier
      lambda
        with identifier
        or
          free-identifier=?: identifier, verb
          classifier-adjective?: classifier, verb
      classifier-adjective?-procedure classifier
      classifier-adverb?-procedure classifier
      classifier-label?-procedure classifier

  define
    classifier+adverb: classifier, adverb
    make-classifier
      classifier-noun?-procedure classifier
      classifier-verb?-procedure classifier
      classifier-adjective?-procedure classifier
      lambda
        with identifier
        or
          free-identifier=?: identifier, adverb
          classifier-adverb?: classifier, adverb
      classifier-label?-procedure classifier

  define
    classifier+adjective: classifier, adjective
    make-classifier
      classifier-noun?-procedure classifier
      classifier-verb?-procedure classifier
      lambda
        with identifier
        or
          free-identifier=?: identifier, adjective
          classifier-adjective?: classifier, adjective
      classifier-adverb?-procedure classifier
      classifier-label?-procedure classifier

  define
    classifier-transform: classifier, stx
    syntax-case
      stx
      keywords: from
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adjective?: classifier, syntax id1
          classifier-adjective?: classifier, syntax id2
        identifier-append: syntax id1, syntax id1, syntax -, syntax id2
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adjective?: classifier, syntax id1
          classifier-adjective?: classifier, syntax id2
        let
          with adjective identifier-append: syntax id1, syntax id1, syntax -, syntax id2
          classifier-transform
            classifier+adjective: classifier, adjective
            quasisyntax : unsyntax adjective, xs, ...
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adjective?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        identifier-append: syntax id1, syntax id1, syntax -, syntax id2
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adjective?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        let
          with noun identifier-append: syntax id1, syntax id1, syntax -, syntax id2
          classifier-transform
            classifier+noun: classifier, noun
            quasisyntax : unsyntax noun, xs, ...
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adverb?: classifier, syntax id1
          classifier-adverb?: classifier, syntax id2
        identifier-append: syntax id1, syntax id1, syntax -, syntax id2
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adverb?: classifier, syntax id1
          classifier-adverb?: classifier, syntax id2
        let
          with adverb identifier-append: syntax id1, syntax id1, syntax -, syntax id2
          classifier-transform
            classifier+adverb: classifier, adverb
            quasisyntax : unsyntax adverb, xs, ...
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adverb?: classifier, syntax id1
          classifier-verb?: classifier, syntax id2
        identifier-append: syntax id1, syntax id1, syntax -, syntax id2
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-adverb?: classifier, syntax id1
          classifier-verb?: classifier, syntax id2
        let
          with verb identifier-append: syntax id1, syntax id1, syntax -, syntax id2
          classifier-transform
            classifier+verb: classifier, verb
            quasisyntax : unsyntax verb, xs, ...
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-noun?: classifier, syntax id1
          classifier-label?: classifier, syntax id2
        identifier-append: syntax id1, syntax id1, syntax -, syntax id2
      when
        id1 from id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-noun?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        identifier-append: syntax id1, syntax id2, syntax ->, syntax id1
      when
        id1 from id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-noun?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        let
          with noun identifier-append: syntax id1, syntax id2, syntax ->, syntax id1
          quasisyntax : unsyntax noun, xs, ...
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-noun?: classifier, syntax id1
          classifier-label?: classifier, syntax id2
        let
          with noun identifier-append: syntax id1, syntax id1, syntax -, syntax id2
          classifier-transform
            classifier+noun: classifier, noun
            quasisyntax : unsyntax noun, xs, ...
      when
        id x
        and
          identifier? syntax id
          classifier-noun?: classifier, syntax id
        let
          with predicate identifier-append: syntax id, syntax id, syntax ?
          quasisyntax ensure: unsyntax predicate, x
      when
        id1 id2
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-verb?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        identifier-append: syntax id1, syntax id2, syntax -, syntax id1
      when
        id1 id2: xs, ...
        and
          identifier? syntax id1
          identifier? syntax id2
          classifier-verb?: classifier, syntax id1
          classifier-noun?: classifier, syntax id2
        let
          with verb identifier-append: syntax id1, syntax id2, syntax -, syntax id1
          classifier-transform
            classifier+verb: classifier, verb
            quasisyntax : unsyntax verb, xs, ...
      when
        other
        syntax other
