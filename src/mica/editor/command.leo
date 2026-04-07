library
  mica editor command
  export
    command
    command-init!
    command-put!
  import
    leo scheme
    mica pointer
    mica ftype
    char

  define-ftype command-arg bits
    present? unsigned 1
    value unsigned 31

  define-ftype command packed struct
    args array: 15, command-arg
    private-char wchar
    char wchar
    flags bits
      escape? unsigned 1
      csi? unsigned 1
      execute? unsigned 1
      _ unsigned 1
      arg-count unsigned 4

  define
    char-terminator? char
    let
      with char-code char->integer char
      and
        >=: char-code, 64
        <=: char-code, 126

  define
    command-init!: command-pointer
    ftype-fill!: command, command-pointer, 0

  define
    command-put!: command-pointer, char
    cond
      when
        zero? ftype-ref: command, command-pointer, flags, escape?
        ftype-set!: command, command-pointer, flags, execute?, 0
        case
          char
          when
            #\x1b
            ftype-set!: command, command-pointer, flags, escape?, 1
            ftype-set!: command, command-pointer, flags, csi?, 0
          else
            ftype-set!: command, command-pointer, char, char
      when
        zero? ftype-ref: command, command-pointer, flags, csi?
        case
          char
          when
            #\[
            ftype-set!: command, command-pointer, flags, csi?, 1
            ftype-set!: command, command-pointer, flags, arg-count, 0
            ftype-set!: command, command-pointer, args, 0, present?, 0
          else
            ftype-set!: command, command-pointer, flags, escape?, 0
            ftype-set!: command, command-pointer, flags, execute?, 1
            ftype-set!: command, command-pointer, char, char
      when
        not zero? ftype-ref: command, command-pointer, flags, execute?
        cond
          when
            char=?: char, #\[
            ftype-set!: command, command-pointer, flags, csi?, 1
            ftype-set!: command, command-pointer, flags, arg-count, 0
          else
            ftype-set!: command, command-pointer, flags, execute?, 0
            ftype-set!: command, command-pointer, char, char
      when
        char-numeric? char
        let*
          with
            digit subtract: char->integer char, char->integer #\0
            index ftype-ref: command, command-pointer, flags, arg-count
            arg ftype-&ref: command, command-pointer, args, index
          if
            zero? ftype-ref: command-arg, arg, present?
            then
              ftype-set!: command-arg, arg, present?, 1
              ftype-set!: command-arg, arg, value, char->integer char
            else
              ftype-set!
                command-arg, arg, value
                add
                  multiply
                    ftype-ref: command-arg, arg, value
                    10
                  digit
      when
        char=?: char, #\;
        ftype-set!
          command, command-pointer, flags, arg-count
          fx1+ ftype-ref: command, command-pointer, flags, arg-count
      when
        char-terminator? char
        ftype-set!: command, command-pointer, flags, execute?, 1
        ftype-set!: command, command-pointer, char, char
