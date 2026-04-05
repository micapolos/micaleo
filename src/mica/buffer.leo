library
  mica buffer
  export
    make-buffer
    buffer?

    buffer-string
    buffer-slack-start
    buffer-slack-end

    set-buffer-string!
    set-buffer-slack-start!
    set-buffer-slack-end!

    make-empty-buffer

    buffer-length
    buffer-slack-start
    buffer-slack-end
    buffer-slack-length
    buffer-head-length
    buffer-tail-length

    buffer-slack-fill!
    buffer-resize!
    buffer-insert!
  import
    leo scheme
    mica pot

  define-record buffer with
    mutable string
    mutable unsigned slack-start
    mutable unsigned slack-end

  define
    make-empty-buffer:
    make-buffer: "", 0, 0

  define
    buffer-length buffer
    subtract
      string-length buffer-string buffer
      buffer-slack-length buffer

  define
    buffer-head-length buffer
    buffer-slack-start buffer

  define
    buffer-tail-length buffer
    subtract
      string-length buffer-string buffer
      buffer-slack-end buffer

  define
    buffer-slack-length buffer
    subtract
      buffer-slack-end buffer
      buffer-slack-start buffer

  define
    buffer-slack-fill!: buffer, char
    substring-fill!
      buffer-string buffer
      buffer-slack-start buffer
      buffer-slack-end buffer
      char

  define
    buffer-resize!: buffer, new-length
    let*
      with
        string buffer-string buffer
        new-string make-string new-length
        length-delta subtract: string-length new-string, string-length string
        new-slack-end add: buffer-slack-end buffer, length-delta
      string-copy!
        string
        0
        new-string
        0
        buffer-head-length buffer
      string-copy!
        string
        buffer-slack-end buffer
        new-string
        new-slack-end
        buffer-tail-length buffer
      set-buffer-string!: buffer, new-string
      set-buffer-slack-end!: buffer, new-slack-end

  define
    buffer-insert!: buffer, string
    when
      less?: buffer-slack-length buffer, string-length string
      buffer-resize!
        buffer
        nearest-pot add: buffer-length buffer, string-length string
    string-copy!
      string
      0
      buffer-string buffer
      buffer-slack-start buffer
      string-length string
    set-buffer-slack-start!
      buffer
      add
        buffer-slack-start buffer
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
          buffer-slack-start first-buffer
          buffer-slack-start second-buffer
        recurse
          buffer-slack-end first-buffer
          buffer-slack-end second-buffer

  record-type-hash-procedure
    record-type-descriptor buffer
    lambda
      with: buffer, recurse
      equal-hash vector
        recurse buffer-string buffer
        recurse buffer-slack-start buffer
        recurse buffer-slack-end buffer
