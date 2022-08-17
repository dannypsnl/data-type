#lang typed/racket

(provide data)

(require syntax/parse/define
         (for-syntax racket/syntax
                     syntax/stx))

(begin-for-syntax
  (define-syntax-class binding
    #:datum-literals (:)
    (pattern (name:id : ty)
      #:attr pair
      #'(name : ty))
    (pattern ty
      #:attr pair
      #`(#,(generate-temporary) : ty)))
  (define-syntax-class constructor
    (pattern (name:id b*:binding ...)
      #:attr bind* #'(b*.pair ...))))

(define-syntax-parser data
  [(_ name:id c*:constructor ...)
   (with-syntax ([(c-name* ...) (stx-map (lambda (id) (format-id id #:source id "~a:~a" #'name id)) #'(c*.name ...))])
     #'(begin
         (struct name () #:transparent)
         (struct c-name* name c*.bind* #:transparent) ...))])

(module+ test
  (require typed/rackunit)

  (data E
        [Int Integer]
        [Add E E])

  (: Eval : E -> Integer)
  (define (Eval e)
    (match e
      [(E:Int v) v]
      [(E:Add l r) (+ (Eval l) (Eval r))]))

  (check-equal? (Eval (E:Add (E:Int 1) (E:Int 2))) 3))
