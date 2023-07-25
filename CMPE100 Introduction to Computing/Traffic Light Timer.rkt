;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trafficlight-timer) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "htdp") (lib "universe.ss" "teachpack" "2htdp")))))
;visual constants
(define R 50)
(define W (* 2 R))
(define D (* 6 R))
(define ES (empty-scene W D))
(define FRAME (rectangle W D "outline" "black"))


(define REDL 
  (place-image
   (overlay/xy
    (overlay/xy
     (overlay/xy FRAME  0 (* -2 R) (circle R "solid" "red"))
     0 0 (circle R "outline" "yellow"))
    0 (* 2 R) (circle R "outline" "green"))
   (/ W 2) (/ D 2) ES))

(define YELLOWL (place-image 
                 (overlay/xy
                  (overlay/xy
                   (overlay/xy FRAME  0 (* -2 R) (circle R "outline" "red"))
                   0 0 (circle R "solid" "yellow"))
                  0 (* 2 R) (circle R "outline" "green"))
                 (/ W 2) (/ D 2) ES))

(define GREENL (place-image
                (overlay/xy
                 (overlay/xy
                  (overlay/xy FRAME  0 (* -2 R) (circle R "outline" "red"))
                  0 0 (circle R "outline" "yellow"))
                 0 (* 2 R) (circle R "solid" "green"))
                (/ W 2) (/ D 2) ES))


;TrafficLight (TL) is one of
; - "red"
; - "yellow"
; - "green"
; interp. each string above represents a corresponding traffic light.

(define-struct NTL (Light Timer))
; NTL is a structure like
; (make-NTL String Number)
; Light is TL
; Timer is a Number represents time passed so far for the current light

;Time for each color
(define RT 9)
(define GT 6)
(define YT 3)



;TASK-1) Write constructors:

;CONSTRUCTOR

;........................



;TASK-2) Write Selectors:

;SELECTOR

;.........................



;TASK-3) Write predicate:

;PREDICATE

;.........................




; Contract: tick-f: NTL --> NTL 
; Purpose:Check the counter of NTL.
; If it is equal to 0, change the light, otherwise subtract one from counter
; (define (new-nxt w) w)
; Example:
(check-expect (tick-f (make-NTL "red" 0))(make-NTL "green" GT))
(check-expect (tick-f (make-NTL "red" 4))(make-NTL "red" 3))
(check-expect (tick-f (make-NTL "green" 0))(make-NTL "yellow" YT))
(check-expect (tick-f (make-NTL "yellow" 2))(make-NTL "yellow" 1))

;TASK-4) Write other examples:
;..........................

;TASK-5) Write template:
;..........................

;TASK-6) Write your code:
;..........................



; Contract:change-light: TL --> NTL
; Purpose: change the light and produce a new traffic light
; (define (change-light atl)(make-NTL "red" RL))
(check-expect (change-state "red")(make-NTL "green" GT))
(check-expect (change-state "green")(make-NTL "yellow" YT))
(check-expect (change-state "yellow")(make-NTL "red" RT))

;TASK-7) Write other examples:
;..........................

;TASK-8) Write template:
;..........................

;TASK-9) Write your code:
;..........................



;Contract: draw-f: NTL --> Image
;Purpose: to draw the current traffic light
;(define (draw-f antl) REDL)
(check-expect (draw-f (make-NTL "red" 4))REDL)
(check-expect (draw-f (make-NTL "green" 0))GREENL)

;TASK-10) Write other examples:
;..........................

;TASK-11) Write template:
;..........................

;TASK-12) Write your code:
;..........................



; KeyEvent is one of:
; - "r"
; - "g"
; - "y"
; - all other keyevents

; Contract: police-officer: NTL KeyEvent --> NTL
; Purpose: to change the light according to key event.
; if KeyEvent is r --> "red"
; if KeyEvent is g --> "green"
; if KeyEvent is y --> "yellow"

(check-expect (police-officer (make-NTL "red" 4) "r")(make-NTL "red" RT))
(check-expect (police-officer (make-NTL "red" 4) "g")(make-NTL "green" GT))

;TASK-13) Write other examples:
;..........................

;TASK-14) Write template:
;..........................

;TASK-15) Write your code:
;..........................



;NTL --> Images
(define (simulate init)
  (big-bang
   init
   (on-tick tick-f)
   (on-draw draw-f)
   (on-key police-officer)))

(simulate (make-NTL "yellow" 3))