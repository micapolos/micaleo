import
  mica scheme
  leonardo term
  leonardo evaluated

check evaluated? evaluated
check equal?: evaluated, evaluated

check equal?
  make-evaluated-term make-native "foo"
  make-annotated
    make-native evaluated
    make-native "foo"

check term-evaluated? make-evaluated-term make-native "foo"
check not term-evaluated? make-native "foo"
