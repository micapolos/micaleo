import
  leo scheme
  mica qualifier

define-qualifier my
define-qualifier? string

check equal?: qualifier? my, true
check equal?: qualifier? string, true
check equal?: qualifier? append, false
