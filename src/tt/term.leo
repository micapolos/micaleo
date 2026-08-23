library
  tt term
  export
    kind
    kind?
    kind-index

    variable
    variable?
    variable-index

    abstraction
    abstraction?
    abstraction-procedure

    product
    product?
    product-param
    product-procedure

    application
    application?
    application-lhs
    application-rhs

    hole
    hole?
    hole-index

    binding
    binding?
    binding-quantity
    binding-ref
  import
    leo scheme
    data
    union

  data binding: quantity, ref

  data kind index
  data variable index
  data abstraction procedure
  data product: param, procedure
  data application: lhs, rhs
  data hole index

  union term: kind, variable, abstraction, product, application, hole
