library
  mica editor command
  export
    command-ftype
  import
    leo scheme
    mica pointer
    char

  define-ftype argument-ftype bits
    present? unsigned 1
    value unsigned 31

  define-ftype command-ftype packed struct
    arguments array: 15, argument-ftype
    private-char wchar
    char wchar
    flags bits
      escape? unsigned 1
      csi? unsigned 1
      complete? unsigned 1
      _ unsigned 1
      argument-count unsigned 4

  define
    char-terminator? char
    let
      with char-code char->integer char
      and
        >=: char-code, 64
        <=: char-code, 126

  define
    command-put!: command, char
    cond
      when
        zero? ftype-ref: command-ftype, command, flags, escape?
        case
          char
          when
            values #\x1b
            ftype-set!: command-ftype, command, flags, escape?, 1
            ftype-set!: command-ftype, command, flags, csi?, 0
          else
            ftype-set!: command-ftype, command, char, char
      when
        not zero? ftype-ref: command-ftype, command, flags, complete?
        cond
          when
            char=?: char, #\[
            ftype-set!: command-ftype, command, flags, csi?, 1
            ftype-set!: command-ftype, command, flags, argument-count, 0
            ftype-set!: command-ftype, command, flags, argument-count, 0
          else
            ftype-set!: command-ftype, command, flags, complete?, 0
            ftype-set!: command-ftype, command, char, char
      when
        zero? ftype-ref: command-ftype, command, flags, csi?
        ftype-set!: command-ftype, command, flags, complete?, 1
        ftype-set!: command-ftype, command, char, char
      when
        char-numeric? char
        let*
          with
            digit subtract: char->integer char, char->integer #\0
            index ftype-ref: command-ftype, command, flags, argument-count
            argument ftype-&ref: command-ftype, command, arguments, index
          if
            zero? ftype-ref: argument-ftype, argument, present?
            then
              ftype-set!: argument-ftype, argument, present?, 1
              ftype-set!: argument-ftype, argument, value, char->integer char
            else
              ftype-set!
                argument-ftype, argument, value
                add
                  multiply
                    ftype-ref: argument-ftype, argument, value
                    10
                  digit
      when
        char=?: char, #\;
        ftype-set!
          command-ftype, command, flags, argument-count
          fx1+ ftype-ref: command-ftype, command, flags, argument-count
      when
        char-terminator? char
        ftype-set!: command-ftype, command, flags, complete?, 1
        ftype-set!: command-ftype, command, char, char

  define
    put-command-ftype-pointer: port, command
    if
      zero? ftype-ref: command-ftype, command, flags, escape?
      then
        put-u8
          port
          ftype-ref: command-ftype, command, char
      else void:
