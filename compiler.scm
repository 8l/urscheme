;;; A compiler from a subset of R5RS Scheme to x86 assembly, written in itself.
;;; Kragen Javier Sitaker, 2008
;;; I think this is nearly the smallest subset of R5RS Scheme that
;;; it's practical to write a Scheme compiler in.

;;; Implemented:
;;; - car, cdr, cons
;;; - symbol?, null?, eq?, boolean?, pair?, string?, procedure?,
;;;   integer?, char?
;;; - if, lambda (with fixed numbers of arguments and a single body
;;;   expression)
;;; - begin
;;; - variables, with lexical scope
;;; - top-level define of a variable (not a function)
;;; - read, for proper lists, symbols, strings, integers, and #t and #f
;;; - eof-object?
;;; - garbage collection
;;; - strings, with string-set!, string-ref, string literals,
;;;   string=?, string-length, and make-string with one argument
;;; - which unfortunately requires characters
;;; - very basic arithmetic: two-argument +, -, and = for integers,
;;;   and decimal numeric constants
;;; - recursive procedure calls
;;; - display, for strings, and newline

;;; All of this would be a little simpler if strings were just lists
;;; of small integers.

;;; Not implemented:
;;; - call/cc, dynamic-wind
;;; - macros, quasiquote
;;; - most of arithmetic
;;; - vectors
;;; - most of the language syntax: dotted pairs, ' ` , ,@
;;; - write
;;; - proper tail recursion
;;; - set!
;;; - cond, case, and, or, do, not
;;; - let, let*, letrec
;;; - delay, force
;;; - internal definitions
;;; - most of the library procedures for handling lists, characters
;;; - eval, apply
;;; - map, for-each
;;; - multiple-value returns
;;; - scheme-report-environment, null-environment

(define skeleton 
  (lambda ()
    (writeln "         .section .rodata")
    (newline)
    (display "hello:  ")
    (newline)
    (display "        .ascii \"hello, world\\n\"")
    (newline)
    (display "        .text")
    (newline)
    (display "        .globl main")
    (newline)
    (display "main:")
    (newline)
    (display "        mov $4, %eax            # __NR_write")
    (newline)
    (display "        mov $1, %ebx            # fd 1: stdout")
    (newline)
    (display "        mov $hello, %ecx        # const void *buf")
    (newline)
    (display "        mov $13, %edx           # size_t count: length of string")
    (newline)
    (display "        int $0x80")
    (newline)
    (display "        mov $0, %eax            # return code")
    (newline)
    (display "        ret")
    (newline)))

(skeleton)
