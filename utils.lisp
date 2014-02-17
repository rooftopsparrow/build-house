;;;;; utils

; Subtract one from each element in the list
(defun minusOne (L)
  (cond 
    ( (null L) NIL) 
    ( (cons (- (car L) 1) (minusOne (cdr L)) ) )
  )
)

; finds the diff between the first
; list and the second list
; returns a list of elements
(defun diff (first second)
  (cond
    ( (null first) nil)
    ( (not (member (car first) second) )
      (cons (car first) (diff (cdr first) second) )
    )
    ( (diff (cdr first) second) )
  )
)

; Returns the item in a list
; at a zero based index
(defun at (L n)
  (cond
    ((null L) nil)
    ((= n 0) (car L))
    ((at (cdr L) (- n 1)))
  )
)

; checks to see if element 
; is a member of a list
(defun is-member (i L)
  (cond
    ((null L) nil)
    ((eq i (car L)) T)
    ((is-member i (cdr L)))
  )
)
