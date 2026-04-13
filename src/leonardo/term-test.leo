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
