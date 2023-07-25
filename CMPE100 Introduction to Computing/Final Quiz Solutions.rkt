;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname final_quiz_solutions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct emp (id salary dept))
;is a structure like
;(make-emp number number string)
;id is a number and repr. id number of each employee
;salary is a number and repr. salary of each employee
;dept is a string and repr. department of each employee

;constructor
(define e1 (make-emp 1 4000 "A"))
(define e2 (make-emp 2 4500 "B"))
(define e3 (make-emp 3 5000 "C"))
(define e4 (make-emp 4 3000 "D"))
(define e5 (make-emp 5 2000 "A"))
(define e6 (make-emp 6 1000 "B"))

;selector
(emp-id e1)
(emp-salary e2)
(emp-dept e3)

;predicator
(emp? e1)


;********************************************************************

;LOE is one of
;empty
;(cons emp LOE)

(define el (list e1 e2 e3 e4 e5 e6))

;2. Design and implement a function named findSalary which consumes a list of Customer structure and a Employee ID,
;then the function returns the salary of given Employee ID.
; findSalary: LOE id ---> salary

(check-expect (findSalary el 3) 5000)

(define (findSalary loe id)
(cond
((empty? loe) 0)
((= id (emp-id (first loe))) (emp-salary (first loe)))
(else (findSalary (rest loe) id))))

(findSalary el 3)


;3. (15pts) Design and implement a function named findDeptList which consumes a list of Employee structure and a department
;information and produces list of Employee IDs in that particular department. 

;findDeptList: LOE dept --> list of emp-id
(check-expect (findDeptList el "A") (list 1 5))

(define (findDeptList loe dept)
(cond
((empty? loe) '())
((string=? dept (emp-dept (first loe))) (cons (emp-id (first loe))
                                       (findDeptList (rest loe) dept)))
(else  (findDeptList (rest loe) dept))))

(findDeptList el "A")


;4. (20pts) Design and implement an accumulator style function named sumSalary>3000 which consumes a list of Employee structures
;and produces sum of Salary greater than 3000.

;sumSalary>300: LOE ---> number
(check-expect (SumSalary>3000 el) 13500)


(define (SumSalary>3000 alox0)
  (local ((define (SumSalary>3000-acc alox accumulator)	
	    (cond
	      [(empty? alox) accumulator]
              ((> (emp-salary (first alox)) 3000)
               (SumSalary>3000-acc (rest alox)(+ (emp-salary (first alox))
                                                 accumulator)))
              (else (SumSalary>3000-acc (rest alox) accumulator)))))
	    (SumSalary>3000-acc alox0 0)))

(SumSalary>3000 el)
(SumSalary>3000 (list e1 e3 e5))

;5. (10pts) Use proper abstract list processing functions to complete question4.
(foldl + 0 (map (lambda (x) (emp-salary x))
                (filter (lambda (x) (> (emp-salary x) 3000)) el)))


;6. Design and implement a function named howManyTimes which consumes a list of numbers and a number.
;It produces how many times given number is in list.

;LON is one
;empty
;(cons number LON)

;howManyTimes: number LON ---> number
(check-expect (howManyTimes 3 (list 1 2 3 1 3 3 4 2 3)) 4)

(define (howManyTimes num lon)
(cond
((empty? lon) 0)
((= num (first lon)) (+ 1 (howManyTimes num (rest lon))))
(else (howManyTimes num (rest lon)))))

(howManyTimes 3 (list 1 2 3 1 3 3 4 2 3))
(howManyTimes 6 (list 1 2 3 1 3 3 4 2 3))


