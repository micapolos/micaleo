library
  mica editor cellbuffer
  export
    make-empty-cellbuffer
    cellbuffer-length
    cellbuffer->cell-list
    cellbuffer-insert-cell!
    cellbuffer->string
    cellbuffer->bg-vector
    cellbuffer->fg-vector
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
    cellbuffer->bg-vector cellbuffer
    list->vector map: cell->bg, cellbuffer->cell-list cellbuffer

  define
    cellbuffer->fg-vector cellbuffer
    list->vector map: cell->fg, cellbuffer->cell-list cellbuffer

  define
    cellbuffer-length cellbuffer
    fxsrl: bytebuffer-length cellbuffer-bytebuffer cellbuffer, cellbuffer-shift

  define
    cellbuffer-insert-cell!: cellbuffer, cell
    bytebuffer-insert-u32!: cellbuffer-bytebuffer cellbuffer, cell
