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
    and
      evaluated? application-argument application
      native? evaluated-ref application-argument application
      evaluated? application-target application
      let
        with native-refs cons
          native-ref evaluated-ref application-argument application
          native-refs
        cond
          when
            native? evaluated-ref application-target application
            cons
              native-ref evaluated-ref application-target application
              native-refs
          when
            application? evaluated-ref application-target application
            append-application-native-refs?
              evaluated-ref application-target application
              native-refs
          else #f

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
