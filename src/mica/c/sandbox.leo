import
  leo scheme
  syntax

define-keywords mem

define-syntax
  keywords: mem
  when
    c: mem size, x, xs, ...
    dynamic-wind
      lambda
        set-virtual-register!
          mem-virtual-register
          make-bytevector size
        set-virtual-register!
          sp-virtual-register
          size
      lambda
        x, xs, ...
      lambda
        set-virtual-register!
          mem-virtual-register
          0
  when: mem-virtual-register, 0
  when: sp-virtual-register, 1
  when
    mem-bytevector
    virtual-register mem-virtual-register
  when
    mem-u32-ref i
    bytevector-u32-native-ref: mem-bytevector, i
  when
    mem-u32-set!: i, u32
    bytevector-u32-native-set!: mem-bytevector, i, u32
  when
    sp
    virtual-register sp-virtual-register
  when
    set-sp!: n
    set-virtual-register!: sp-virtual-register, n
  when
    push-u32!: u32
    begin
      set-sp! fx-/wraparound: sp, 4
      mem-u32-set!: sp, u32
  when
    pop-u32!
    let
      with u32 mem-u32-ref: sp
      set-sp! fx+/wraparound: sp, 4
      u32

define
  u32-add!:
  let*
    with
      lhs pop-u32!
      rhs pop-u32!
    push-u32! fx+/wraparound: lhs, rhs

c
  mem 16
  push-u32!: 10
  push-u32!: 20
  u32-add!:
  write pop-u32!
