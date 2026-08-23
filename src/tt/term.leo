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
    abstraction-binding

    product
    product?
    product-param
    product-binding

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
    binding-procedure
  import
    leo scheme
    data
    union

  data kind index
  data variable index
  data abstraction binding
  data product: param, binding
  data application: lhs, rhs
  data hole index
  data binding: quantity, procedure

  union term: kind, variable, abstraction, product, application, hole
