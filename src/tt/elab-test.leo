import
  leo scheme
  tt lookup
  tt elab

check-elab
  when elab 10
  10

check-elab
  when: x 10, y 20, elab "foo"
  x 10, y 20, "foo"
