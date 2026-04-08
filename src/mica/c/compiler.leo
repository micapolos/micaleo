library
  mica c compiler
  export compile
  import mica c base

  define
    compile: typeof, stx
    syntax-case
      stx
      when
        id
        keyword? id
        quasisyntax compiled
          unsyntax typeof syntax id
          id
      when
        fx
        fixnum? datum fx
        syntax compiled: fixnum, fx

