library
  leonardo resolve
  export
    application-native-refs?
    application-resolve
  import
    leo scheme
    leonardo term

  define
    append-application-native-refs?: application, native-refs
    switch
      term-unpeel application-argument application
      when
        argument-native native?
        let
          with native-refs cons: native-ref argument-native, native-refs
          switch
            term-unpeel application-target application
            when
              target-native native?
              cons: native-ref target-native, native-refs
            when
              target-application application?
              append-application-native-refs?: target-application, native-refs
            else _ #f
      else _ #f

  define
    application-native-refs? application
    append-application-native-refs?: application, null

  define
    application-resolve: arity-of, application
    let
      with native-refs? application-native-refs? application
      if
        not native-refs?
        then application
        else let
          with
            target car native-refs?
            args cdr native-refs?
          if
            =: arity-of target, length args
            then make-native apply: target, args
            else application
