;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Worksheet7 Solutions|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;..........countDigit..........
;purpose: that takes a number and count the digit/s of given number
;contract: countDigit: number -> number
;examples
(check-expect (countdigit 123) 3)
(check-expect (countdigit 6734) 4)

;function
(define (countdigit x)
  (cond
    ((< x 0) (+ (countdigit (/ (abs x) 10)) 1))
    ((and (>= x 0) (< x 10)) 1)
     ((>= x 10) (+ (countdigit (/ x 10)) 1))))
   

(countdigit 3490856)





;..........sumDigit.........
;purpose: that takes a number and sum the digit/s of given number
;contract: sumDigit: number -> number
;examples
(check-expect (sumDigit 123) 6)
(check-expect (sumDigit 64109) 20)

;fuction
(define (sumDigit y)
  (cond
    ((not (integer? y)) (error "you must give integer"))
    ((= y 0) 0)
    ((> y 0) (+ (modulo y 10) (sumDigit (/ (- y (modulo y 10)) 10))))))
(sumDigit 845)