(load "utils")

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

; given a list of tasks, returns
; a list with their respective times 
(defun gettimes (tasks L)
    (cond
        ((null tasks) nil)
        ((cons
            (gettime (car tasks) L)
            (gettimes (cdr tasks) L))
        )
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
            ((union
                (get-all-preds (car tasks) L)
                (all-preds-helper (cdr tasks) L))
            )
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

; Returns the largest task in the list
(defun largest-task (tasks L)
    (let*
        (
            (m (gettimes tasks L))
        )

        (cond
            ((null m) nil)
            ((at tasks (position (apply #'max m) m)))
        )
    )

)


; Returns the tasks that are on
; the critical path
(defun critical-path (task L)

   (let*
        (
            ; First grab the direct predecessors
            (p (predecessors task L))
            ; Grab the largest one
            (max (largest-task p L))
        )
        (cond
            ((null max) nil)
            ((cons max (critical-path max L)))
        )
    )
    
)

; Returns the start day of a specific task
; 1-based
(defun start-day (task L)
    (+ (apply #'+ (gettimes (critical-path task L) L)) 1)
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
        ((cons
            (finished-day (car tasks) L)
            (finished-times (cdr tasks) L))
        )
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

; Returns whether the task is a dependant of q
; in the list L.
(defun is-dependant (task q L)
    (is-member task (predecessors q L))
)

; Returns the dependants of a task 
; WARN: Incomplete. only finds immediate
; dependants
(defun depends-on (task L)

    (let ((q (caar L)))
        (cond
            ((null q) nil)
            ((is-dependant task q L) 
                (cons q (depends-on task (cdr L)))
            )
            ((depends-on task (cdr L)))
        )
    )
)
