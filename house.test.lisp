; use lisp-unit framework
(load "lib/lisp-unit")
(in-package :lisp-unit)

(load "house")
(load "data")

(define-test test-sum
    (assert-equal 114 (sum *tasks*))
)

(define-test test-predecessors
    (assert-equal '() (predecessors 'purchase_lot *tasks*))
    (assert-equal '(purchase_lot design_house) (predecessors 'get_permit *tasks*))
    (assert-equal '(roof install_windows_doors) (predecessors 'vapor_barrier_insulation *tasks*))
)

(define-test test-gettime
    (assert-equal 3 (gettime 'inside_paint *tasks*))
    (assert-equal 14 (gettime 'get_bids *tasks*))
)

(define-test test-get-all-preds
    (assert-equal '() (get-all-preds 'purchase_lot *tasks*))
    (assert-equal '(get_bids purchase_lot design_house) (get-all-preds 'select_subs *tasks*))
    (assert-equal 
        '(get_permit select_subs purchase_lot design_house get_bids) 
        (get-all-preds 'excavate *tasks*)
    )
)

(define-test test-precedes)

(define-test test-start-day)

(define-test test-get-max)

(define-test test-critical-path)

(define-test test-depends-on)


(setq *print-errors* T)
(setq *print-failures* T)
(run-tests :all)
