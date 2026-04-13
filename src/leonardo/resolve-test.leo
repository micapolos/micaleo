import
  leo scheme
  leonardo term
  leonardo resolve

check equal?
  application-native-refs? make-application
    make-annotated
      make-native "annotation"
      make-native zero?
    make-annotated
      make-native "annotation"
      make-native 123
  list: zero?, 123

check equal?
  application-native-refs? make-application
    make-annotated
      make-native "annotation"
      make-application
        make-annotated
          make-native "annotation"
          make-native string-append
        make-annotated
          make-native "annotation"
          make-native "foo"
    make-annotated
      make-native "annotation"
      make-native "bar"
  list: string-append, "foo", "bar"

define
  arity-of x
  cond
    when
      equal?: x, number->string
      1
    when
      equal?: x, string-append
      2
    else 0

define
  test-application-resolve application
  application-resolve: arity-of, application

comment resolved single argument application
check equal?
  test-application-resolve make-application
    make-annotated
      make-native "annotation"
      make-native number->string
    make-annotated
      make-native "annotation"
      make-native 123
  make-native "123"

comment unresolved single argument application
check equal?
  test-application-resolve make-application
    make-annotated
      make-native "annotation"
      make-native number->string
    make-annotated
      make-native "annotation"
      make-variable 0
  make-application
    make-annotated
      make-native "annotation"
      make-native number->string
    make-annotated
      make-native "annotation"
      make-variable 0

comment partially resolved two argument application
check equal?
  test-application-resolve make-application
    make-annotated
      make-native "annotation"
      make-native string-append
    make-annotated
      make-native "annotation"
      make-native "foo"
  make-application
    make-annotated
      make-native "annotation"
      make-native string-append
    make-annotated
      make-native "annotation"
      make-native "foo"

comment resolved two argument application
check equal?
  test-application-resolve make-application
    make-annotated
      make-native "annotation"
      make-application
        make-annotated
          make-native "annotation"
          make-native string-append
        make-annotated
          make-native "annotation"
          make-native "foo"
    make-annotated
      make-native "annotation"
      make-native "bar"
  make-native "foobar"
