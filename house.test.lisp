; use lisp-unit framework
(load "lib/lisp-unit")
(in-package :lisp-unit)

(load "house") ; house functions
(load "tasks") ; pulls in *tasks*

(define-test test-sum
    (assert-equal 114 (sum *tasks*))
)

(define-test test-predecessors
    (assert-equal '() (predecessors 'purchase_lot *tasks*))
    (assert-equal '(purchase_lot design_house) 
        (predecessors 'get_permit *tasks*))
    (assert-equal '(roof install_windows_doors) 
        (predecessors 'vapor_barrier_insulation *tasks*))
)

(define-test test-gettime
    (assert-equal 3 (gettime 'inside_paint *tasks*))
    (assert-equal 14 (gettime 'get_bids *tasks*))
)

(define-test test-get-all-preds
    (assert-equal '() (get-all-preds 'purchase_lot *tasks*))
    (assert-equal '(get_bids purchase_lot design_house) 
        (get-all-preds 'select_subs *tasks*))
    (assert-equal 
        '(get_permit select_subs get_bids purchase_lot design_house)
        (get-all-preds 'excavate *tasks*)
    )
    (assert-equal
        '(get_windows_doors rough_plumbing rough_electric 
            order_windows_doors frame get_permit select_subs 
            get_bids purchase_lot design_house)
        (get-all-preds 'install_windows_doors *tasks*)
    )
)

(define-test test-critical-path
    (assert-equal '() (critical-path 'design_house *tasks*))
    (assert-equal '(design_house)
        (critical-path 'get_permit *tasks*)
    )
    (assert-equal 
        '(
            install_windows_doors 
            get_windows_doors 
            order_windows_doors
            design_house
        )
        (critical-path 'vapor_barrier_insulation *tasks*)
    )
)

(define-test test-precedes
    (assert-false (precedes 'purchase_lot 'design_house *tasks*))
    (assert-true (precedes 'purchase_lot 'order_windows_doors *tasks*))
    (assert-false (precedes 'outside_paint 'inside_paint *tasks*))
    (assert-true (precedes 'roof 'drywall *tasks*))
)

(define-test test-start-day
    (assert-equal 1 (start-day 'purchase_lot *tasks*))
    (assert-equal 6 (start-day 'get_permit *tasks*))
    (assert-equal 6 (start-day 'get_bids *tasks*))
    (assert-equal 23 (start-day 'construct_basement *tasks*))
)

(define-test test-get-max
    (assert-equal '(6 design_house) 
        (get-max '(design_house purchase_lot) *tasks*))
    (assert-equal '(38 roof) 
        (get-max '(frame roof select_subs) *tasks* ))
)


(define-test test-depends-on
    (assert-equal '(connections landscape) 
        (depends-on 'move_house *tasks*))
)


(setq *print-errors* T)
(setq *print-failures* T)
(run-tests :all)
