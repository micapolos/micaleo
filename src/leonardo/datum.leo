library
  leonardo datum
  export term->datum
  import
    leo scheme
    leonardo term

  define
    depth-procedure->datum: depth, procedure
    let
      with variable make-variable depth
      `lambda`
        `with` depth-term->datum: depth, variable
        depth-term->datum
          +: depth, 1
          with: procedure, variable

  define
    depth-term->datum: depth, term
    switch term
      when
        native native?
        `native` native-ref native
      when
        variable variable?
        `variable` variable-depth variable
      when
        abstraction abstraction?
        `abstraction` depth-procedure->datum: depth, abstraction-procedure abstraction
      when
        abstraction-type abstraction-type?
        `abstraction-type`
          depth-term->datum: depth, abstraction-type-parameter abstraction-type
          depth-procedure->datum: depth, abstraction-type-procedure abstraction-type
      when
        application application?
        `application`
          depth-term->datum: depth, application-target application
          depth-term->datum: depth, application-argument application
      when
        evaluated evaluated?
        `evaluated` depth-term->datum: depth, evaluated-ref evaluated
      when
        annotated annotated?
        `annotated`
          depth-term->datum: depth, annotated-annotation annotated
          depth-term->datum: depth, annotated-ref annotated
      else other
        assertion-violation `not term` other

  define term->datum partial: depth-term->datum, 0
