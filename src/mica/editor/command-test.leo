import
  leo scheme
  mica ftype
  mica editor command

let-ftype
  with
    test-command command
    expected-command command

  command-init!: test-command
  command-init!: expected-command

  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\a
  ftype-set!: command, expected-command, char, #\a
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\x1b
  ftype-set!: command, expected-command, flags, escape?, 1
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\H
  ftype-set!: command, expected-command, flags, escape?, 0
  ftype-set!: command, expected-command, flags, execute?, 1
  ftype-set!: command, expected-command, char, #\H
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\x1b
  ftype-set!: command, expected-command, flags, escape?, 1
  ftype-set!: command, expected-command, flags, execute?, 0
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\[
  ftype-set!: command, expected-command, flags, csi?, 1
  ftype-set!: command, expected-command, flags, arg-count, 0
  ftype-set!: command, expected-command, args, 0, present?, 0
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\3
  ftype-set!: command, expected-command, args, 0, present?, 1
  ftype-set!: command, expected-command, args, 0, value, 3
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\4
  ftype-set!: command, expected-command, args, 0, present?, 1
  ftype-set!: command, expected-command, args, 0, value, 34
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\5
  ftype-set!: command, expected-command, args, 0, present?, 1
  ftype-set!: command, expected-command, args, 0, value, 345
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\;
  ftype-set!: command, expected-command, args, 1, present?, 0
  ftype-set!: command, expected-command, flags, arg-count, 1
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\6
  ftype-set!: command, expected-command, args, 1, present?, 1
  ftype-set!: command, expected-command, args, 1, value, 6
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\;
  ftype-set!: command, expected-command, args, 2, present?, 0
  ftype-set!: command, expected-command, flags, arg-count, 2
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\;
  ftype-set!: command, expected-command, args, 3, present?, 0
  ftype-set!: command, expected-command, flags, arg-count, 3
  check-ftype=?: test-command, expected-command

  command-put!: test-command, #\m
  ftype-set!: command, expected-command, args, 3, present?, 0
  ftype-set!: command, expected-command, flags, arg-count, 3
  ftype-set!: command, expected-command, flags, escape?, 0
  ftype-set!: command, expected-command, flags, execute?, 1
  ftype-set!: command, expected-command, char, #\m
  check-ftype=?: test-command, expected-command
