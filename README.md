# data-type

[![Test](https://github.com/dannypsnl/data-type/actions/workflows/test.yml/badge.svg)](https://github.com/dannypsnl/data-type/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/dannypsnl/data-type/badge.svg?branch=develop)](https://coveralls.io/github/dannypsnl/data-type?branch=develop)

### Usage

```
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
