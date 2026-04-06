library
  mica editor command
  export
    command-ftype
  import
    leo scheme
    mica pointer

  define-ftype command-ftype packed struct
    arguments array: 14, unsigned-16
    _ unsigned-8
    escape bits
      started? unsigned 1
      csi? unsigned 1
      complete? unsigned 1
      _ unsigned 1
      argument-count unsigned 4
    private-char unsigned-8
    char unsigned-8

  define
    make-command:
    ftype-make-pointer: command-ftype

  define
    put-command-ftype-pointer: port, command-ftype-pointer
    if
      zero? ftype-ref: command-ftype, command-ftype-pointer, escape, started?
      then
        put-u8
          port
          ftype-ref: command-ftype, command-ftype-pointer, char
      else void:
