import
  leo scheme
  leonardo term

check equal?
  term-unpeel make-native "foo"
  make-native "foo"

check equal?
  term-unpeel make-annotated
    make-native "annotation"
    make-native "foo"
  make-native "foo"

check equal?
  term-unpeel make-annotated
    make-native "annotation"
    make-annotated
      make-native "annotation"
      make-native "foo"
  make-native "foo"

check equal?
  term-unpeel make-application
    make-native "foo"
    make-annotated
      make-native "annotation"
      make-native "bar"
  make-application
    make-native "foo"
    make-annotated
      make-native "annotation"
      make-native "bar"

define-term stringed string

define-terms
  numbered number
  booleaned boolean

check stringed? make-stringed: "foo", make-native 'my-string
check numbered? make-numbered: 123, make-native 'my-number
check booleaned? make-booleaned: true, make-native 'my-boolean

check not stringed? make-numbered: 123, make-native 'my-number

check equal?
  stringed-string make-stringed: "foo", make-native 'my-string
  "foo"

check equal?
  stringed-ref make-stringed: "foo", make-native 'my-string
  make-native 'my-string

check equal?
  stringed-string make-native-stringed: "foo"
  "foo"

check equal?
  stringed-ref make-native-stringed: "foo"
  make-native "foo"
