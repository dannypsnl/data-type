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

(define-for-syntax ((C-name prefix) id)
  (if prefix
      (format-id id #:source id "~a:~a" prefix id)
      id))

(define-syntax-parser data
  [(_ (~or name:id
           (name:id v*:id ...))
      (~or (~seq #:prefix (~optional prefix:id #:defaults ([prefix #'name])))
           (~seq))
      c*:constructor ...)
   (with-syntax ([(c-name* ...) (stx-map (C-name (attribute prefix)) #'(c*.name ...))])
     (if (attribute v*)
         #'(begin (struct (v* ...) name () #:transparent)
                  (struct (v* ...) c-name* name c*.bind* #:transparent) ...)
         #'(begin (struct name () #:transparent)
                  (struct c-name* name c*.bind* #:transparent) ...)))])

(module+ test
  (require typed/rackunit)

  (data K [Int Integer])
  (check-true (K? (Int 1)))

  (data (Foo T) [V T])
  (check-true (Foo? (V 1)))

  (data Bar #:prefix [V Integer])
  (check-true (Bar? (Bar:V 1)))

  (data Expr #:prefix E
        [Int Integer]
        [Add Expr Expr])

  (: Eval : Expr -> Integer)
  (define (Eval e)
    (match e
      [(E:Int v) v]
      [(E:Add l r) (+ (Eval l) (Eval r))]))

  (check-equal? (Eval (E:Add (E:Int 1) (E:Int 2))) 3)

  (data (LIST T) #:prefix L
        [Nil]
        [Cons T (LIST T)])

  (: Len : (∀ (T) (LIST T) -> Natural))
  (define (Len L)
    (match L
      [(L:Nil) 0]
      [(L:Cons t Tail) (add1 (Len Tail))]))

  (check-equal? (Len (L:Cons 1 (L:Nil)))
                1))
