#lang scribble/manual

@require[@for-label[data-type
                    racket/base]]

@title{data-type}
@author{Lîm Tsú-thuàn}

@defmodule[data-type]

@defform[
 (data type-signature
       maybe-prefix-form
       clause ...)
 #:grammar
 [(type-signature type-name
                  (type-name type-variable ...))
  (maybe-prefix-form #:prefix
                     (code:line #:prefix prefix-id))
  (clause [name param ...])
  (param type
         [param-name type])]
 ]{
 Just like the data type you would see in Haskell and ML, which supports parametric polymorphism. The prefix form is for namespacing the constructor of data type. The following is a normal usage, the constructors are all without namespacing.

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

 To have namespacing prefix, use the following code. The data type still @code{Expr} here, but the constructors will get @code{E:} prefix automatically.

 @racketblock[
 (data Expr #:prefix E
       [Int Integer]
       [Add Expr Expr])

 (: Eval : Expr -> Integer)
 (define (Eval e)
   (match e
     [(E:Int v) v]
     [(E:Add l r) (+ (Eval l) (Eval r))]))

 (Eval (E:Add (E:Int 1) (E:Int 2)))
 ]

 And if you require @code{#:prefix} but didn't provide an identifier, it will use data type @code{LIST} as prefix.

 @racketblock[
 (data (LIST T) #:prefix
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
