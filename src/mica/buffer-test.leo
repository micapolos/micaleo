import
  leo scheme
  mica buffer

check equal?
  with empty-buffer
  buffer: box "", box 0, box 0, box #t

check equal?
  buffer-size with empty-buffer
  0
