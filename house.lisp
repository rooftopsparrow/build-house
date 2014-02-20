(load "functions")

; utility function for checking 
; if the task is the top of the
; list
(defun matchTask (task L)
    (eq task (caar L))
)

; The sum of all jobs in L
(defun sum (L)
    (apply 'sumAll (each-nth L 1))
)

; returns a list of jobs that needs 
; to be performed for a task in L
(defun predecessors (task L)
    (cond
        ((null task) nil)
        ((matchTask task L) (cddr (car L) ))
        ((predecessors task (cdr L)))
    )
)

; returns the time for a task in L
(defun gettime (task L)
    (cond
        ((matchTask task L) (at (car L) 1))
        ((gettime task (cdr L)))
    )
)


; return a list of all predecessors
; for a given task
(defun get-all-preds (task L)

    ; Helper recusivly calls parent and itself on each item
    ; it receives 
    (defun all-preds-helper (tasks L)
        (cond
            ((null tasks) nil)
            ((union (get-all-preds (car tasks) L) (all-preds-helper (cdr tasks) L)))
        )
    )

    (let
        (
            ; First grab the direct predecessors
            (p (predecessors task L))
        )
        ; Union that with recursive call
        (union p (all-preds-helper p L))
    )
)

; Returns true or false whether the
; first task precedes the second
(defun precedes (first second L)
    (is-member first (get-all-preds second L))
)

; Returns the start day of a specific task
(defun start-day (task L)

    ; Takes a list and returns the sum of days
    (defun start-day-helper (tasks L)
        (cond 
            ((null tasks) 1)
            ((+ (gettime (car tasks) L) (start-day-helper (cdr tasks) L) ))
        )
    )
    (let 
        ((p (get-all-preds task L)))
        (+ (start-day-helper p L))
    )
)

; Helper method to return 
; the day a task will be finished
(defun finished-day (task L)
    (+ (gettime task L) (start-day task L))
)

; Takes a list of tasks and returns their times
; in respective order
(defun finished-times (tasks L)
    (cond
        ((null tasks) nil)
        ((cons (finished-day (car tasks) L) (finished-times (cdr tasks) L)))
    )
)

; takes a list tasks and returns 
; the time and the job that finishes 
; in the greatest time
(defun get-max (tasks L)
    (let*
        (
            (timeL (finished-times tasks L))
            (maxT (apply #'max timeL))
        )
        (list maxT (at tasks (position maxT timeL)))
    )
)

