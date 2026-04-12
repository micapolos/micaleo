library
  mica classifier
  export
    is
    noun, verb, adjective, adverb, label, unclassified
    unclassified-identifier->class
    identifier->class+
    make-identifier->class
    classify
  import leo scheme

  define-keywords: is, noun, verb, adjective, adverb, label, unclassified

  define unclassified-identifier->class
    lambda
      with identifier
      syntax unclassified

  define
    identifier->class+: identifier->class, new-identifier, class
    lambda
      with identifier
      if
        free-identifier=?: identifier, new-identifier
        then class
        else identifier->class identifier

  define-syntax rules
    when
      make-identifier->class:
      unclassified-identifier->class
    when
      make-identifier->class: xs, ..., identifier class
      identifier->class+
        make-identifier->class: xs, ...
        syntax identifier
        syntax class

  define
    classify: identifier->class, stx
    syntax-case
      stx
      keywords: is, from
      when
        id
        identifier? syntax id
        syntax-case
          identifier->class syntax id
          when: class, syntax class id
      when
        is x
        syntax-case
          classify: identifier->class, syntax x
          keywords: noun, verb, adjective, adverb, label, unclassified
          when
            noun noun-id
            identifier? syntax noun-id
            quasisyntax noun unsyntax identifier-append: syntax id, syntax noun-id, syntax ?
          when
            noun noun-id: xs, ...
            identifier? syntax noun-id
            quasisyntax noun :
              unsyntax identifier-append: syntax id, syntax noun-id, syntax ?
              xs, ...
          when
            _ x
            syntax unclassified is x
      when
        id from x
        identifier? syntax id
        syntax-case
          quasisyntax classified
            unsyntax identifier->class syntax id
            unsyntax classify: identifier->class, syntax x
          keywords: noun, verb, adjective, adverb, label, unclassified
          when
            classified
              noun
              noun noun-id
            identifier? syntax noun-id
            quasisyntax noun
              unsyntax identifier-append: syntax id, syntax noun-id, syntax ->, syntax id
          when
            classified
              noun
              noun noun-id: xs, ...
            identifier? syntax noun-id
            quasisyntax noun :
              unsyntax identifier-append: syntax id, syntax noun-id, syntax ->, syntax id
              xs, ...
          when
            classified: class, _ x
            syntax class id from x
      when
        id x
        identifier? syntax id
        syntax-case
          quasisyntax classified
            unsyntax identifier->class syntax id
            unsyntax classify: identifier->class, syntax x
          keywords: noun, verb, adjective, adverb, label, unclassified
          when
            classified
              adjective
              adjective adjective-id
            identifier? syntax adjective-id
            quasisyntax adjective
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax adjective-id
          when
            classified
              adjective
              adjective adjective-id: xs, ...
            identifier? syntax adjective-id
            quasisyntax adjective :
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax adjective-id
              xs, ...
          when
            classified
              adjective
              noun noun-id
            identifier? syntax noun-id
            quasisyntax noun
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax noun-id
          when
            classified
              adjective
              noun noun-id: xs, ...
            identifier? syntax noun-id
            quasisyntax noun :
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax noun-id
              xs, ...
          when
            classified
              noun
              label label-id
            identifier? syntax x-id
            quasisyntax noun
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax label-id
          when
            classified
              noun
              label label-id: xs, ...
            identifier? syntax x-id
            quasisyntax noun :
              unsyntax identifier-append: syntax id, syntax id, syntax -, syntax label-id
              xs, ...
          when
            classified: class, _ x
            syntax class id x
      when
        other
        syntax unclassified other
