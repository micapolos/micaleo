library
  tt term
  export
    kind
    kind?
    kind-index

    native
    native?
    native-ref

    abstraction
    abstraction?
    abstraction-binding

    product
    product?
    product-domain
    product-binding

    application
    application?
    application-target
    application-argument

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

  data binding: quantity, procedure
  data native ref
  data kind index
  data abstraction binding
  data product: domain, binding
  data application: target, argument
  data hole index

  union term: native, kind, abstraction, product, application, hole
