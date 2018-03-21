#lang racket

(define (mirror tree)
  (if (eq? tree 'leaf)
      tree
      (let ([left-subtree (caddr tree)]
            [right-subtree (cadddr tree)]
            [value (cadr tree)])
        (list 'node value (mirror right-subtree) (mirror left-subtree)))))