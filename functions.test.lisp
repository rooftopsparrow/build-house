(load "lib/lisp-unit") ; use lisp-unit framework
(in-package :lisp-unit)

(load "functions")

;; utility function testing

(define-test test-minusOne
    (assert-equal '(0 1 2 3) (minusOne '(1 2 3 4)) )
    (assert-equal '() (minusOne '()) )
)

(define-test test-diff
    (assert-equal '(0 9) (diff '(0 3 4 7 9 4) '(4 7 5 8 3)) )
    (assert-equal nil (diff '(1 2) '(2 1)) )
)

(define-test test-at
    (assert-equal nil (at '(1 2 3) 5))
    (assert-equal 6 (at '(9 8 7 6 5 4 3 2 1) 3))
)

(define-test test-is-member
    (assert-equal NIL (is-member 'a '(b c d)))
    (assert-equal T (is-member 'a '(a b c)))
)

;; Homework functions

(define-test test-deleteAt
    (assert-equal '(1 2 4 5) (deleteAt '(1 2 3 4 5) 2)) 
    (assert-equal '(2 3 4 5) (deleteAt '(1 2 3 4 5) 0))
    (assert-equal '(1 2 3 4 5) (deleteAt '(1 2 3 4 5) 6))
    (assert-equal '(1 2 3 4 5) (deleteAt '(1 2 3 4 5) -1))
    (assert-equal '(A B C E) (deleteAt '(A B C D E) 3)) ; From hw
)

(define-test test-deleteAllAt
    (assert-equal '(1 2 3 4 5 6) (deleteAllAt '(1 2 3 4 5 6) 6))
    (assert-equal '(1 2 3 4 5 6) (deleteAllAt '(1 2 3 4 5 6) -1))
    (assert-equal '(2 3 4 5 6) (deleteAllAt '(1 2 3 4 5 6) 0))
    (assert-equal '(1 3 5) (deleteAllAt '(1 2 3 4 5 6) 1 3 5))
    (assert-equal '(C E) (deleteAllAt '(A B C D E) 0 1 3)) ; from hw
)

(define-test test-sumAll
    (assert-equal 15 (sumAll 1 2 3 4 5))
    (assert-equal 0 (sumAll))
    (assert-equal 13 (sumAll '(/ 8 4) '(+ 5 6) ))
    (assert-equal 39 (sumAll 3 4 '(* 5 6) 2)) ; from hw
)

(define-test test-similar
    (assert-equal nil (similar '(a b c) '(x y z)) )
    (assert-equal '(1) (similar '(5 7 1) '(2 1 3)) )
    (assert-equal '(B) (similar '(A B C D E) '(X (A C) B R L)) ) ; from hw
)

(define-test test-different
    (assert-equal '() (different '(1 2 3) '(3 1 2) ))
    (assert-equal '(A B C) (different '(A D E) '(D B C E)))
    (assert-equal '(A C D E X (A C) R L) 
        (different '(A B C D E) '( X (A C) B R L))
    ) ; from hw
)

(define-test test-last-item
    (assert-equal "G" (last-item '("A" "B" "T" "G")) )
    (assert-equal '(A B) (last-item '(E G F (A B)) ) )
    (assert-equal nil (last-item '() ) )
    (assert-equal "YUP" (last-item '("YUP") ) )
)

(define-test test-mcons
    (assert-equal nil (mcons))
    (assert-equal '(1 2) (mcons '(1 2)))
    (assert-equal '(a b c d e) (mcons 'a 'b 'c '(d e)))
)

(define-test each-nth
    (assert-equal '() ())
    (assert-equal '(1 2 3) (each-nth '((1 3) (2 4) (3 5)) 0) )
    (assert-equal '(mary ann greg judy)
        (each-nth '(
            (fred mary sue)
            (sam ann dave martin)
            (hank greg joe bill)
            (jo judy pat jane)
        ) 1)
    )
)

(setq *print-errors* T)
(setq *print-failures* T)
(run-tests :all)
