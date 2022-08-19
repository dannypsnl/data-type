# data-type


[![Test](https://github.com/dannypsnl/data-type/actions/workflows/racket-test.yml/badge.svg)](https://github.com/dannypsnl/data-type/actions/workflows/racket-test.yml)
[![Coverage Status](https://badgen.net/https/dannypsnl.github.io/data-type/coverage/badge.json)](https://dannypsnl.github.io/data-type/coverage)
[![Documentation](https://img.shields.io/badge/docs-published-blue)](https://docs.racket-lang.org/data-type)

### Usage

```racket
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
```
