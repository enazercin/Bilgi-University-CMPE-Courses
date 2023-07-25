;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Elif Naz Erçin Worksheet 04|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;QUESTION 1
;contract num -> num
;purpose: to write celcius as a fahrenheit
(check-expect (fromCeltoFahr 20) 68)
;function
(define (fromCeltoFahr a) (+ (* a 1.8) 32))
(fromCeltoFahr 10)


;QUESTION 2
;contract: num->num
;Purpose: to find area of rectangle
(check-expect (areaofRect 5 10) 50)
;function
(define (areaofRect x y) (* x y))
(areaofRect 10 20)


;QUESTION 3
;contract: num -> image
;purpose: to draw a rectangle
(check-expect (drawRect 50 30) (rectangle 50 30 "outline" "black"))
;function
(define (drawRect a b) (rectangle a b "outline" "black"))
(drawRect 20 30)


;QUESTION 4
;contract num->num
;purpose to calculate BMI
(check-expect (calculateBMI 45 1.50) 20)
;function
(define (calculateBMI x y) (/ x (sqr y)))
(calculateBMI 52 1.69)


;QUESTION 5
;contants
;width
(define W 400)
;height
(define H 400)
(define MYSCN (empty-scene W H))

(define MYIMG (overlay (rectangle 60 10 "solid" "black")
                       (circle 20 "solid" "red")))

;data definition: number
;purpose: to animate image
;contract: AnimIMG: number (Y) --> image
;examples
(check-expect (AnimIMG 150) (place-image MYIMG 150 150 MYSCN))
(check-expect (AnimIMG 0) (place-image MYIMG 0 0 MYSCN))
(check-expect (AnimIMG 10) (place-image MYIMG 10 10 MYSCN))

;function header:
;(define (AnimIMG y) MYSCN)
;template:
;(define (AnimIMG y) (...y...))
;function
(define (AnimIMG y)
  (place-image MYIMG y y MYSCN))

(AnimIMG 100)
(animate AnimIMG)
