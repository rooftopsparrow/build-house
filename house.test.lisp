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
        '(get_permit select_subs get_bids purchase_lot design_house)
        (get-all-preds 'excavate *tasks*)
    )
    (assert-equal
        '(get_windows_doors rough_plumbing rough_electric order_windows_doors frame 
            get_permit select_subs get_bids purchase_lot design_house)
        (get-all-preds 'install_windows_doors *tasks*)
    )
)

(define-test test-precedes
    (assert-false (precedes 'purchase_lot 'design_house *tasks*))
    (assert-true (precedes 'purchase_lot 'order_windows_doors *tasks*))
    (assert-false (precedes 'outside_paint 'inside_paint *tasks*))
    (assert-true (precedes 'roof 'drywall *tasks*))
)

(define-test test-start-day
    (assert-equal 0 (start-day 'purchase_lot *tasks*))
    (assert-equal 7 (start-day 'get_permit *tasks*))
    (assert-equal 25 (start-day 'construct_basement *tasks*))
)

(define-test test-get-max)

(define-test test-critical-path)

(define-test test-depends-on)


(setq *print-errors* T)
(setq *print-failures* T)
(run-tests :all)
