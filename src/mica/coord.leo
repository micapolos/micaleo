library
  mica coord
  export
    coord-size
    coord-x-offset
    coord-y-offset
    alloc-coord
    free-coord
    coord-x
    coord-y
    set-coord-x!
    set-coord-y!
    set-coord-xy!
  import
    leo scheme
    mica mem

  define-syntax rules
    when: coord-size, 4
    when: coord-x-offset, 0
    when: coord-y-offset, 2
    when
      alloc-coord
      mem-alloc sizeof-coord
    when
      set-coord-xy!: coord, x, y
      begin
        mem-u16-set!: coord, x
        set! coord fx+/wraparound: coord, 2
        mem-u16-set!: coord, y
    when
      free-coord
      mem-free sizeof-coord
    when
      coord-x coord
      mem-u16-ref: coord, coord-x-offset
    when
      coord-y coord
      mem-u16-ref: coord, coord-y-offset
    when
      set-coord-x!: coord, x
      mem-u16-set!: coord, coord-x-offset, x
    when
      set-coord-y!: coord, y
      mem-u16-set!: coord, coord-y-offset, y
