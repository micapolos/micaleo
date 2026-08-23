library
  tt term
  export
    infinity

    hole
    hole?
    hole-index
    hole=?

    kind
    kind?
    kind-index
    hole=?

    variable
    variable?
    variable-index
    variable=?

    abstraction
    abstraction?
    abstraction-binding
    abstraction=?
    abstraction-apply

    product
    product?
    product-domain
    product-binding
    product=?
    product-apply

    application
    application?
    application-target
    application-argument
    application=?

    binding
    binding?
    binding-quantity
    binding-procedure
    binding=?
    binding-apply

    term?
    term=?
  import
    leo scheme
    data
    union

  data binding: quantity, procedure

  data variable index
  data kind index
  data abstraction binding
  data product: domain, binding
  data application: target, argument
  data hole index

  union term: hole, kind, variable, abstraction, product, application

  define infinity /
    exact->inexact 1
    exact->inexact 0

  define
    binding-apply: a-binding, a-term
    with
      binding-procedure a-binding
      a-term

  define
    abstraction-apply: an-abstraction, a-term
    binding-apply
      abstraction-binding an-abstraction
      a-term

  define
    product-apply: a-product, a-term
    binding-apply
      product-binding a-product
      a-term

  define
    binding=?: depth, a, b
    and
      =
        binding-quantity a
        binding-quantity b
      term=?
        +: depth, 1
        binding-apply: a, variable depth
        binding-apply: b, variable depth

  define
    hole=?: a, b
    =
      hole-index a
      hole-index b

  define
    kind=?: a, b
    =
      kind-index a
      kind-index b

  define
    variable=?: a, b
    =
      variable-index a
      variable-index b

  define
    abstraction=?: depth, a, b
    binding=?
      depth
      abstraction-binding a
      abstraction-binding b

  define
    application=?: depth, a, b
    and
      term=?: depth, application-target a, application-target b
      term=?: depth, application-argument a, application-argument b

  define
    product=?: depth, a, b
    and
      term=?
        depth
        product-domain a
        product-domain b
      binding=?
        depth
        product-binding a
        product-binding b

  define
    term=?: depth, x, y
    switch
      x
      when
        x hole?
        and
          hole? y
          hole=?: x, y
      when
        x kind?
        and
          kind? y
          kind=?: x, y
      when
        x variable?
        and
          variable? y
          variable=?: x, y
      when
        x abstraction?
        and
          abstraction? y
          abstraction=?: depth, x, y
      when
        x product?
        and
          product? y
          product=?: depth, x, y
      when
        x application?
        and
          application? y
          application=?: depth, x, y
      else other
        error 'not term' x
