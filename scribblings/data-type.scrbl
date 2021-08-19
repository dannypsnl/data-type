#lang scribble/manual

@require[@for-label[data-type
                    racket/base]]

@title{data-type}
@author{Lîm Tsú-thuàn}

@defmodule[data-type]

@defform[
      (data type-name
            clause ...)
      #:grammar
      [(clause [name param ...])
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
}
