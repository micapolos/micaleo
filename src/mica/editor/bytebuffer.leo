library
  mica editor bytebuffer
  export
    make-bytebuffer
    bytebuffer?

    bytebuffer-bytevector
    bytebuffer-slack-start
    bytebuffer-slack-end

    set-bytebuffer-bytevector!
    set-bytebuffer-slack-start!
    set-bytebuffer-slack-end!

    make-empty-bytebuffer

    bytebuffer-length
    bytebuffer-slack-start
    bytebuffer-slack-end
    bytebuffer-slack-length
    bytebuffer-head-length
    bytebuffer-tail-length

    bytebuffer-slack-fill!
    bytebuffer-resize!
    bytebuffer-insert!
  import
    leo scheme
    mica bytevector
    mica pot

  define-record bytebuffer with
    mutable bytevector
    mutable unsigned slack-start
    mutable unsigned slack-end

  define
    make-empty-bytebuffer:
    make-bytebuffer
      bytevector:
      0, 0

  define
    bytebuffer-length bytebuffer
    subtract
      bytevector-length bytebuffer-bytevector bytebuffer
      bytebuffer-slack-length bytebuffer

  define
    bytebuffer-head-length bytebuffer
    bytebuffer-slack-start bytebuffer

  define
    bytebuffer-tail-length bytebuffer
    subtract
      bytevector-length bytebuffer-bytevector bytebuffer
      bytebuffer-slack-end bytebuffer

  define
    bytebuffer-slack-length bytebuffer
    subtract
      bytebuffer-slack-end bytebuffer
      bytebuffer-slack-start bytebuffer

  define
    bytebuffer-slack-fill!: bytebuffer, byte
    bytevector-fill-range!
      bytebuffer-bytevector bytebuffer
      bytebuffer-slack-start bytebuffer
      bytebuffer-slack-end bytebuffer
      byte

  define
    bytebuffer-resize!: bytebuffer, new-length
    let*
      with
        bytevector bytebuffer-bytevector bytebuffer
        new-bytevector make-bytevector new-length
        length-delta subtract: bytevector-length new-bytevector, bytevector-length bytevector
        new-slack-end add: bytebuffer-slack-end bytebuffer, length-delta
      bytevector-copy!
        bytevector
        0
        new-bytevector
        0
        bytebuffer-head-length bytebuffer
      bytevector-copy!
        bytevector
        bytebuffer-slack-end bytebuffer
        new-bytevector
        new-slack-end
        bytebuffer-tail-length bytebuffer
      set-bytebuffer-bytevector!: bytebuffer, new-bytevector
      set-bytebuffer-slack-end!: bytebuffer, new-slack-end

  define
    bytebuffer-insert!: bytebuffer, bytevector
    when
      less?: bytebuffer-slack-length bytebuffer, bytevector-length bytevector
      bytebuffer-resize!
        bytebuffer
        nearest-pot add: bytebuffer-length bytebuffer, bytevector-length bytevector
    bytevector-copy!
      bytevector
      0
      bytebuffer-bytevector bytebuffer
      bytebuffer-slack-start bytebuffer
      bytevector-length bytevector
    set-bytebuffer-slack-start!
      bytebuffer
      add
        bytebuffer-slack-start bytebuffer
        bytevector-length bytevector

  record-type-equal-procedure
    record-type-descriptor bytebuffer
    lambda
      with: first-bytebuffer, second-bytebuffer, recurse
      and
        recurse
          bytebuffer-bytevector first-bytebuffer
          bytebuffer-bytevector second-bytebuffer
        recurse
          bytebuffer-slack-start first-bytebuffer
          bytebuffer-slack-start second-bytebuffer
        recurse
          bytebuffer-slack-end first-bytebuffer
          bytebuffer-slack-end second-bytebuffer

  record-type-hash-procedure
    record-type-descriptor bytebuffer
    lambda
      with: bytebuffer, recurse
      equal-hash vector
        recurse bytebuffer-bytevector bytebuffer
        recurse bytebuffer-slack-start bytebuffer
        recurse bytebuffer-slack-end bytebuffer
