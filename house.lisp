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

(defun get-all-preds (task L)
    (cond
        ((null task) nil)
        (
            (let ((p (predecessors task L)))
                (append p (get-all-preds (car p) L)) 
            )
        )
    )
)
