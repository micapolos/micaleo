library
  mica buffer
  export
    make-buffer
    buffer?

    buffer-string
    buffer-slack
    buffer-position
    buffer-forward?

    set-buffer-string!
    set-buffer-slack!
    set-buffer-position!
    set-buffer-forward?!

    make-empty-buffer

    buffer-length
    buffer-slack-start-position
    buffer-slack-end-position
    buffer-head-length
    buffer-tail-length

    change-buffer-slack!
    buffer-insert!
  import
    leo scheme
    mica pot

  define-record buffer with
    mutable string
    mutable slack
    mutable position
    mutable forward?

  define
    make-empty-buffer:
    make-buffer: "", 0, 0, #t

  define
    buffer-length buffer
    subtract
      string-length buffer-string buffer
      buffer-slack buffer

  define
    buffer-slack-start-position buffer
    if
      buffer-forward? buffer
      then buffer-position buffer
      else subtract
        buffer-position buffer
        buffer-slack buffer

  define
    buffer-slack-end-position buffer
    if
      buffer-forward? buffer
      then add
        buffer-position buffer
        buffer-slack buffer
      else buffer-position buffer

  define
    buffer-head-length buffer
    buffer-slack-start-position buffer

  define
    buffer-tail-length buffer
    subtract
      string-length buffer-string buffer
      buffer-slack-end-position buffer

  define
    change-buffer-slack!: buffer, slack
    let*
      with
        old-string buffer-string buffer
        new-string make-string
          add
            string-length old-string
            subtract: slack, buffer-slack buffer
          char _
        new-position if
          buffer-forward? buffer
          buffer-position buffer
          add: buffer-slack-start-position buffer, slack
      string-copy!
        old-string
        0
        new-string
        0
        buffer-head-length buffer
      string-copy!
        old-string
        buffer-slack-end-position buffer
        new-string
        if
          buffer-forward? buffer
          add: new-position, slack
          new-position
        buffer-tail-length buffer
      set-buffer-string!: buffer, new-string
      set-buffer-slack!: buffer, slack
      set-buffer-position!: buffer, new-position

  define
    buffer-insert!: buffer, string
    when
      not buffer-forward? buffer
      set-buffer-position!: buffer, buffer-slack-start-position buffer
      set-buffer-forward?!: buffer, #t
    when
      less?: buffer-slack buffer, string-length string
      change-buffer-slack!
        buffer
        subtract
          nearest-pot add: buffer-length buffer, string-length string
          buffer-length buffer
    string-copy!
      string
      0
      buffer-string buffer
      buffer-slack-start-position buffer
      string-length string
    set-buffer-position!
      buffer
      add
        buffer-position buffer
        string-length string
    set-buffer-slack!
      buffer
      subtract
        buffer-slack buffer
        string-length string

  record-type-equal-procedure
    record-type-descriptor buffer
    lambda
      with: first-buffer, second-buffer, recurse
      and
        recurse
          buffer-string first-buffer
          buffer-string second-buffer
        recurse
          buffer-slack first-buffer
          buffer-slack second-buffer
        recurse
          buffer-position first-buffer
          buffer-position second-buffer
        recurse
          buffer-forward? first-buffer
          buffer-forward? second-buffer

  record-type-hash-procedure
    record-type-descriptor buffer
    lambda
      with: buffer, recurse
      equal-hash vector
        recurse buffer-string buffer
        recurse buffer-slack buffer
        recurse buffer-position buffer
        recurse buffer-forward? buffer
