;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Existing Abstractions|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
;Existing Abstractions

;build-list
(define (add2 n)
  (+ n 2))
(add2 5)

(build-list 3 add1)
(build-list 3 add2)


;filter
(filter odd? (list 2 5 8 4 2 5 4 65))
(filter even? (list 2 4 58 4 5521 4 6 43 2))

(define (large-enough? x)
    (>= x 3))

(filter large-enough? '( 1 5 13 21 43 20))

;sort
(sort (list 2 5 84 321 8 4 652) >)
(sort (list 2 5 84 321 8 4 652) <)

;map
(define (tag-with-a x)
  (list "a" (+ x )))
(map tag-with-a (list 2 3 5))


(define (tag-with-a-2 y)
  (list "a" (+ y 1)))
(map tag-with-a-2 (list 2 4 5))


(map add1 (list  2 3 5 6 8 10 5))