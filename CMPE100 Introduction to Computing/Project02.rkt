;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Elif Naz Erçin Project02|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
;Question-3
;Item is a structure which has three fields
;(make-Item number string string ("beverage", "snack" "pasta") number number)
;Data Definitions: Strings
;Contract: String--> number string string number number

;Code
(define-struct Item (itemID itemName itemType itemPrice itemStock))

;Constructors:
(define i1  (make-Item 1 "Cola" "beverage" 5 1000))
(define i2  (make-Item 2 "FuseTea" "beverage"  3.5 5000))
(define i3  (make-Item 3 "Chips" "snack" 12 3000))
(define i4  (make-Item 4 "Biscuit" "snack" 3 10000))
(define i5  (make-Item 5 "Angel Hair" "pasta" 3 20000))
(define i6  (make-Item 6 "Pappardelle" "pasta" 2 15000))
(define i7  (make-Item 7 "Pepsi" "beverage" 4.5 1000))
(define i8  (make-Item 8 "IceTea" "beverage"  4 5000))
(define i9  (make-Item 9 "Patos" "snack" 12 3000))
(define i10 (make-Item 10 "Wafer" "snack" 1.5 10000))
(define i11 (make-Item 11 "Farfalle" "pasta" 3.5 20000))
(define i12 (make-Item 12 "Gnocchi" "pasta" 2.5 15000))

;Selectors:
(Item-itemID i1) ;1
(Item-itemType i4) ;"snack"
(Item-itemPrice i5) ;3


;Predicators:
(Item? i5) ; #true
(Item? i2) ; #true
(Item? "Chips") ;#false


;Question 2
;Brand is a structure which has three fields
;(make-Brand number string list)
;Data Definitions: strings
;Contract: (Brand) string--> number string listofitems

;Code
(define-struct Brand (brandID brandName listOfItems))



;Constructors:
(define b1 (make-Brand 1 "CocaCola"   (list i1 i2))) 
(define b2 (make-Brand 2 "Pepsi"      (list i7 i8))) 
(define b3 (make-Brand 3 "Eti"        (list i3 i4))) 
(define b4 (make-Brand 4 "Ülker"      (list i9 i10))) 
(define b5 (make-Brand 5 "Barilla"    (list i5 i6))) 
(define b6 (make-Brand 6 "PastaVilla" (list i11 i12)))


;Selectors:
(Brand-brandID b1) ;1
(Brand-brandName b3) ;"Eti"
(Brand-listOfItems b4)  ; (make-Item 4 "Biscuit" "snack" 3 10000)

;Predicators
(Brand? b1) ;#true
(Brand? b3) ;#true
(Brand? 42) ;#false


;1
;Market is a structure which has two fields
;(make-Market number list)
;Data definitions: string
;Contract: string-> number list

;code
(define-struct Market (marketID brandList))



;Constructors:
(define Migros      (make-Market 1 (list b1 b2 b3)))
(define MacroCenter (make-Market 2 (list b4 b5 b6)))

                                 
;Selectors:                                 
(Market-marketID Migros) ; 1
(Market-marketID MacroCenter) ;2


;Predicators:
(Market? Migros) ;#true
(Market? MacroCenter) ;#true
(Market? 10) ;#false

;4
;Data definitions: string
;contract: string-->list
(define-struct Basket (listOfItems))
;basket is a structure
;(make-basket list)
(define ba0 (make-Basket '()))
(define ba1 (make-Basket (list i4)))


;1---
;helper function
;data definitions: list,  number
;contract: alist,number->alist
(define (helper1 alist disc)
  (cond
    ((empty? alist) empty)
    (else (cons (make-Item (Item-itemID (first alist)) (Item-itemName (first alist))
                           (Item-itemType (first alist))
                           (- (Item-itemPrice (first alist))(* (/ disc 100)(Item-itemPrice (first alist))))
                           (Item-itemStock (first alist))) (helper1 (rest alist) disc)))))
;Main function
;data definitions: structure
;contract: structure structue structure structure->structure

(define (discount amarket abrand adiscount)
  (cond
    ((not (member?  abrand (Market-brandList amarket))) (error "Brand not in Market"))
    ((string=? (Brand-brandName abrand) (Brand-brandName (first (Market-brandList amarket))))
    (make-Market(Market-marketID amarket)
                (cons (make-Brand (Brand-brandID (first (Market-brandList amarket)))
                      (Brand-brandName (first(Market-brandList amarket)))
                      (helper1 (Brand-listOfItems (first (Market-brandList amarket))) adiscount))
                (rest (Market-brandList amarket)))))
  (else (discount (make-Market (Market-marketID amarket) (append (rest (Market-brandList amarket))
                                                                  (cons (first (Market-brandList amarket)) empty))) abrand adiscount))))

 

;2--
;helper function 2
;data definitions: list
;contract: list string->number
(define (helper2 alist atype ad)
  (cond
    ((empty? alist) empty)
    ((string=? (Item-itemType (first alist)) atype) (cons (make-Item (Item-itemID (first alist)) (Item-itemName (first alist))
                                                                     (Item-itemType (first alist)) (-(Item-itemPrice (first alist))(*(/ ad 100)(Item-itemPrice (first alist))))
                                                                     (Item-itemStock (first alist))) (helper2 (rest alist) atype ad)))
    (else ( cons (first alist) (helper2 (rest alist) atype ad)))))



;helpfer function 3
;data definition: strings
;contract: string number->structure
(define (helper3 abrand atype adisc)
  (cons (make-Brand (Brand-brandID abrand) (Brand-brandName abrand) (helper2 (Brand-listOfItems abrand) atype adisc))))


;helpfer function 4
;data definition list
;contract: alist string number->string number
(define (helper4 alistofbrands atype adisc)
  (cond
    ((empty? alistofbrands)empty)
    (else (cons (helper3 (first alistofbrands) atype adisc) (helper3 (rest alistofbrands) atype adisc)))))


;main function
;data definition: strings and number
;contract: string string string number-> structure
(define (typedis amarket atype adisc)
  (make-Market (Market-marketID amarket) (helper3 (Market-brandList amarket) atype adisc)))


;3--
;helper 5
;data definitions: structure
;contract: structure->boolean
(define (helper5 anitemlist anitem)
  (cond
    ((empty? anitemlist) #false)
    ((equal? anitem (first anitemlist)) #true)
    ((not(equal? anitem (first anitemlist))) (helper5 (rest anitemlist) anitem))))

;helper 6
;data definitions: structure and structure
;contract: structure->boolean
(define (helper6 abrandlist anitem)
  (cond
    ((empty? abrandlist) #false)
    ((helper5 (Brand-listOfItems (first abrandlist))anitem) #true)
    (else (helper6 (rest abrandlist) anitem))))

;main function
;data definition: structures and number
;contract: structure structue number -> structure
(define (puttobasket amarket abasket anitem amount)
  (cond
    ((not (Market? amarket)) (error "not a valid market"))
    ((not (Item? anitem)) (error "not a valid item"))
    ((not (Basket? abasket)) (error "not a basket"))
    ((not (integer? amount)) (error "not a number"))
    ((< (Item-itemStock anitem) amount) (error "there are not that many items in the stock"))
    ((helper6 (Market-brandList amarket) anitem)
     (make-Basket (cons(make-Item(Item-itemID anitem) (Item-itemName anitem) (Item-itemType anitem) (Item-itemPrice anitem) amount) (Basket-listOfItems abasket))))
     (else(error" this item is not in this market"))))

;helper 7
;data definitions: list
;contract: alist->list
(define (helper7 anitemlist)
  (foldr (lambda ( x y) (cons (*(Item-itemPrice x)(Item-itemStock x))y)) '() anitemlist))



;helper 8
;data definitions: list
;contract: list->list
(define(helper8 pricelist)
   (cond
     ((empty? pricelist) 0)
     (else (+ (first pricelist) (helper8 (rest pricelist))))))

;main function
;data definitions:structure
;contract: structure->structure
(define (totalprice1 abasket)
    (cond
      ((not(Basket? abasket)) (error "not a basket"))
      ((empty? (Basket-listOfItems abasket))0)
      (else (helper8 (helper7 (Basket-listOfItems abasket))))))


;data definitions: list
;contract: list->list
(define(extract p? lot)
  (cond
    ((empty? lot)0)
    ((p? (first lot)) (+(* (Item-itemPrice (first lot)) (Item-itemStock (first lot))) (extract p? (rest lot))))
    (else (error "error"))))

;data definitions: structure
;contract: structure->structure
(define (totalprice2 abasket) (extract Item? (Basket-listOfItems abasket)))