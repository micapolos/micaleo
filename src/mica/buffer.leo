library
  mica buffer
  export
    buffer, buffer?
    buffer-string-box
    buffer-slack-box
    buffer-position-box
    buffer-forward?-box
    empty-buffer
    buffer-length
    buffer-resize-slack!
  import leo scheme

  define
    record buffer
      string-box
      slack-box
      position-box
      forward?-box

    lambda empty-buffer
      buffer: box "", box 0, box 0, box #t

    lambda
      buffer-string buffer
      unbox buffer-string-box buffer

    lambda
      buffer-slack buffer
      unbox buffer-slack-box buffer

    lambda
      buffer-position buffer
      unbox buffer-position-box buffer

    lambda
      buffer-forward? buffer
      unbox buffer-forward?-box buffer

    lambda
      buffer-string-set!: buffer, string
      set-box!: buffer-string-box buffer, string

    lambda
      buffer-slack-set!: buffer, slack
      set-box!: buffer-slack-box buffer, slack

    lambda
      buffer-position-set!: buffer, position
      set-box!: buffer-position-box buffer, position

    lambda
      buffer-forward?-set!: buffer, forward?
      set-box!: buffer-forward?-box buffer, forward?

    lambda
      buffer-length buffer
      subtract
        string-length buffer-string buffer
        buffer-slack buffer

    lambda
      buffer-slack-start-position buffer
      if
        buffer-forward? buffer
        then buffer-position buffer
        else subtract
          buffer-position buffer
          buffer-slack buffer

    lambda
      buffer-slack-end-position buffer
      if
        buffer-forward? buffer
        then add
          buffer-position buffer
          buffer-slack buffer
        else buffer-position buffer

    lambda
      buffer-head-length buffer
      buffer-slack-start-position buffer

    lambda
      buffer-tail-length buffer
      subtract
        string-length buffer-string buffer
        buffer-slack-end-position buffer

    lambda
      buffer-resize-slack!: buffer, slack
      let sequential
        old-string buffer-string buffer
        new-string make-string
          add
            string-length
            subtract
              slack
              buffer-slack buffer
        new-position
          if
            buffer-forward? buffer
            then buffer-position
            else add: buffer-slack-start-position buffer, slack
        in
          string-copy!
            old-string
            0
            new-string
            0
            buffer-head-length buffer
          string-copy
            old-string
            buffer-slack-end-position buffer
            new-string
            new-position
            buffer-tail-length buffer
          buffer-string-set!: buffer, new-string
          buffer-slack-set!: buffer, slack
          buffer-position-set!: buffer, new-position

