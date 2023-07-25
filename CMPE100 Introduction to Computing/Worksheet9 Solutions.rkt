;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname worksheet_08) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct song (name artist genre year price))
;a song is a stucture:
; (make-song string string string number number)

;constructor:
(define cd1 (make-song "Scream for Silence" "Children of Bodom" "Melodic Death Metal" "2013" "50"))
(define cd2 (make-song "Blank Infinity" "Epica" "Symphonic Metal" "2005" "35"))

;selector
(song-name cd1) ;string
(song-artist cd2) ;string
(song-genre cd2) ;string
(song-year cd2) ;number
(song-price cd2) ;number

;predicate
(song? cd1) ;true
(song? 24) ;false

(define (xxx song G)
  (cond
    ((string=? G (song-genre song)) (song-artist song))
    (else #false)))

(define (yyy song G Y)
  (cond
    ((and (string=? G (song-genre song)) (= Y (song-year song))) (song-price song))
    (else #false)))

(check-expect (xxx cd1 "Melodic Death Metal") "Children of Bodom")
(check-expect (yyy cd2 "Melodic Death Metal" 2013) 50)