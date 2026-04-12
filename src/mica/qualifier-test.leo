import
  leo scheme
  mica qualifier

define-keywords: my, lucky
define-qualifiers: my, lucky

check equal?: qualifier? +, false
check equal?: qualifier? my, true
check equal?: qualifier? lucky, true
