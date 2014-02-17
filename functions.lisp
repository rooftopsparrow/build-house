; Load utility functions
(load "utils")

; deleteAt removes an element from `L` 
; at a specific zero based index
(defun deleteAt (L index)
  (cond 
    ( (null L) NIL )
    ( (eq index 0) (cdr L) )
    ; construct new element with current value and recurse
    ( (cons (car L) (deleteAt (cdr L) (- index 1))) )
  )
)

; deletes all elements given 
; in `indexes` from `L`
(defun deleteAllAt (L &rest indexes)
  (cond
    ( (null indexes) L)
    ( (apply 'deleteAllAt 
        (deleteAt L (car indexes)) 
        (minusOne (cdr indexes))
      )
    ) 
  ) 
)


; Takes the sum of all arguments
(defun sumAll (&rest args)
  (cond
    ( (null args) 0 )
    ( (atom (car args))
      (+ (car args) (apply 'sumAll (cdr args)) )
    )
    ( (+ (eval (car args)) (apply 'sumAll (cdr args)) ) )
  )
)

; Searches one list against another 
; and returns similar elements 
(defun similar (first second)
  (cond
    ( (null first) nil)
    ( (is-member (car first) second) 
      (cons (car first) (similar (cdr first) second) )
    )
    ( ( similar (cdr first) second) )
  )
)

; Return a list of of elements
; that don't appear in either list
(defun different (first second)
  (append (diff first second) (diff second first) )
)

; Return the last item in a list
(defun last-item (L)
  (cond 
    ( (null (cdr L)) (car L) )
    ( (last-item (cdr L)) ) 
  )
)

; Constructs a list using the arguments
(defun mcons (&rest L)
  (cond
    ( (null (cdr L)) (car L) )
    ( (cons (car L) (apply 'mcons (cdr L)) ) )
  )
)

; Returns a list itmes by picking the
; `n`th item from each sublist
; in a list of lists `L`
(defun each-nth (L n)
  (cond
    ( (null L) nil)
    ( (cons (at (car L) n) (each-nth (cdr L) n)) )
  )
)
