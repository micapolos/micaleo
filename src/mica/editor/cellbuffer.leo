library
  mica editor cellbuffer
  export
    make-empty-cellbuffer
    cellbuffer-length
    cellbuffer->cell-list
    cellbuffer-insert-cell!
    cellbuffer-move-forward!
    cellbuffer-move-backward!
    cellbuffer->string
    cellbuffer->background-color-vector
    cellbuffer->foreground-color-vector
  import
    leo scheme
    mica editor cell
    mica editor bytebuffer

  define-record cellbuffer with bytebuffer

  define cellbuffer-shift 2

  define
    with make-empty-cellbuffer
    make-cellbuffer with make-empty-bytebuffer

  define
    cellbuffer->cell-list cellbuffer
    switch
      cellbuffer-length cellbuffer
      when
        _ zero?
        null
      when
        length fixnum?
        bytevector->uint-list
          bytebuffer->bytevector cellbuffer-bytebuffer cellbuffer
          native-endianness:
          4

  define
    cellbuffer->string cellbuffer
    list->string map: cell->char, cellbuffer->cell-list cellbuffer

  define
    cellbuffer->background-color-vector cellbuffer
    list->vector map: cell->background-color, cellbuffer->cell-list cellbuffer

  define
    cellbuffer->foreground-color-vector cellbuffer
    list->vector map: cell->foreground-color, cellbuffer->cell-list cellbuffer

  define
    cellbuffer-length cellbuffer
    fxsrl: bytebuffer-length cellbuffer-bytebuffer cellbuffer, cellbuffer-shift

  define
    cellbuffer-insert-cell!: cellbuffer, cell
    bytebuffer-insert-u32-native!: cellbuffer-bytebuffer cellbuffer, cell

  define
    cellbuffer-move-forward!: cellbuffer
    bytebuffer-move-forward-u32-native! cellbuffer-bytebuffer cellbuffer

  define
    cellbuffer-move-backward!: cellbuffer
    bytebuffer-move-backward-u32-native! cellbuffer-bytebuffer cellbuffer

  record-type-equal-procedure
    record-type-descriptor cellbuffer
    lambda
      with: first-cellbuffer, second-cellbuffer, recurse
      recurse
        cellbuffer-bytebuffer first-cellbuffer
        cellbuffer-bytebuffer second-cellbuffer

  record-type-hash-procedure
    record-type-descriptor cellbuffer
    lambda
      with: cellbuffer, recurse
      recurse cellbuffer-bytebuffer cellbuffer
