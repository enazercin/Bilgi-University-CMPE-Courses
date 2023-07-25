;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Elif Naz Erçin Worksheet 03|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Question 1
(define str "helloworld")
(define i 5)

;Question 2
(circle 100 "solid" "red")
(place-image (circle 100 "solid" "red") 10 40 (rectangle 200 300 "solid" "green"))
(empty-scene 200 200)
(place-image (circle 100 "solid" "red") 10 40 (empty-scene 200 200))

;Question 3
(above (triangle 150 "solid" "black")
       (place-image (square 30 "outline" "black") 40 50
       (place-image (square 30 "outline" "black") 110 50
       (overlay/align "middle" "bottom" (rectangle 50 60 "solid" "black")
                        (square 150 "solid" "red")))))


;Question 4
(define x (above (circle 40 "solid" "red")
  (circle 40 "solid" "red")))
(define y (beside x x))

(overlay y (circle 200 "solid" "green"))