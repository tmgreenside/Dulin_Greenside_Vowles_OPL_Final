


(defun iterf (listt emptyLst)
  (if (null listt)
      emptyLst
    (iterf (cdr listt) (push (car listt) emptyLst))
  )
)

;(setq x '(a b c d))

(print (iterf '(a b c d) nil) )
;     (load "testfile.lisp")
;
