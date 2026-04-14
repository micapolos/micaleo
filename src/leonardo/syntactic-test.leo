import
  mica scheme
  leonardo term
  leonardo datum
  leonardo syntactic

check syntactic? make-annotated
  make-native syntax foo
  make-native 123

check free-syntax=?
  syntactic-syntax make-annotated
    make-native syntax foo
    make-native 123
  syntax foo

check free-syntax=?
  syntactic-syntax make-native-syntactic syntax foo
  syntax foo
