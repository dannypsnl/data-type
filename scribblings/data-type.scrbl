#lang scribble/manual

@require[@for-label[data-type
                    racket/base]]

@title{data-type}
@author{Lîm Tsú-thuàn}

@defmodule[data-type]

@defform[
 (data type-signature
       clause ...)
 #:grammar
 [(type-signature type-name
                  (type-name type-variable ...))
  (clause [name param ...])
  (param type
         [param-name type])]
 ]{
 usage

 @racketblock[
 (data expr
       [Var (name : Symbol)]
       [abs (name : Symbol) (body : expr)]
       [app (fn : expr) (arg : expr)]
       [pi (name : Symbol) (e : expr) (body : expr)]
       [type (level : Integer)]
       [nat]
       [zero]
       [succ (n : expr)]
       [rec expr expr expr expr]
       [id expr expr expr]
       [refl expr]
       [J expr expr expr expr expr expr])
 ]

 More examples

 @racketblock[
 (data E
       [Int Integer]
       [Add E E])

 (: Eval : E -> Integer)
 (define (Eval e)
   (match e
     [(E:Int v) v]
     [(E:Add l r) (+ (Eval l) (Eval r))]))

 (Eval (E:Add (E:Int 1) (E:Int 2)))

 (data (LIST T)
       [Nil]
       [Cons T (LIST T)])

 (: Len : (∀ (T) (LIST T) -> Natural))
 (define (Len L)
   (match L
     [(LIST:Nil) 0]
     [(LIST:Cons t Tail) (add1 (Len Tail))]))

 (Len (LIST:Cons #t (LIST:Nil)))
 ]
}
