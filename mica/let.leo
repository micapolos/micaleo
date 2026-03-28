library
  mica let
  export: in, let
  import
    rename
      let %let
      from leo scheme
    only
      define-keywords
      from micascheme
    keyword

  define-keywords in

  define-syntax
    keywords: in, with, values
    when
      let in body
      body
    when
      let
        with
          values: x, ...
          expr
        spec, ...
        in body
      let*-values
        with
          with
            values: x, ...
            expr
        let
          spec, ...
          in body
    when
      let
        id expr
        spec, ...
        in body
      keyword? id
      %let
        with id expr
        let
          spec, ...
          in body
