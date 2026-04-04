library
  mica buffer
  export
    buffer-type
    make-buffer
    buffer?

    buffer-string
    buffer-slack
    buffer-position
    buffer-forward?

    buffer-string-set!
    buffer-slack-set!
    buffer-position-set!
    buffer-forward?-set!

    make-empty-buffer

    buffer-length
    buffer-slack-start-position
    buffer-slack-end-position
    buffer-head-length
    buffer-tail-length

    buffer-slack-change!
    buffer-insert!
  import
    leo scheme
    mica pot

  define-record buffer
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
    buffer-slack-change!: buffer, slack
    let sequential
      old-string buffer-string buffer
      new-string make-string
        add
          string-length old-string
          subtract: slack, buffer-slack buffer
        char _
      new-position if
        buffer-forward? buffer
        then buffer-position buffer
        else add: buffer-slack-start-position buffer, slack
      in
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
            then add: new-position, slack
            else new-position
          buffer-tail-length buffer
        buffer-string-set!: buffer, new-string
        buffer-slack-set!: buffer, slack
        buffer-position-set!: buffer, new-position

  define
    buffer-insert!: buffer, string
    when
      not buffer-forward? buffer
      buffer-position-set!: buffer, buffer-slack-start-position buffer
      buffer-forward?-set!: buffer, #t
    when
      less?: buffer-slack buffer, string-length string
      buffer-slack-change!
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
    buffer-position-set!
      buffer
      add
        buffer-position buffer
        string-length string
    buffer-slack-set!
      buffer
      subtract
        buffer-slack buffer
        string-length string

  record-type-equal-procedure
    buffer-type
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
    buffer-type
    lambda
      with: buffer, recurse
      equal-hash vector
        recurse buffer-string buffer
        recurse buffer-slack buffer
        recurse buffer-position buffer
        recurse buffer-forward? buffer
