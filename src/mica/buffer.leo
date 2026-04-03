library
  mica buffer
  export
    buffer, buffer?
    buffer-string-box
    buffer-slack-box
    buffer-position-box
    buffer-forward?-box
    empty-buffer
    buffer-size
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
      buffer-slack-set!: buffer, slack
      set-box!: buffer-slack-box buffer, slack

    lambda
      buffer-position-set!: buffer, position
      set-box!: buffer-position-box buffer, position

    lambda
      buffer-forward?-set!: buffer, forward?
      set-box!: buffer-forward?-box buffer, forward?

    lambda
      buffer-size buffer
      subtract
        string-length buffer-string buffer
        buffer-slack buffer
