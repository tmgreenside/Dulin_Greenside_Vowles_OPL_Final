


(defun iterf (listt)
  (if (null listt)
    '()
    (append  '(first listt) (iterf (cdr listt)))
  )
)

(print (iterf '(1 2 3 4 5)))
;     (load "testfile.lisp")
;
