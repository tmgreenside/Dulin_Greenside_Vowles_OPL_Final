


(defun iterf (listt emptyLst)
  (if (null listt)
      emptyLst
    (iterf (cdr listt) (push (car listt) emptyLst))
  )
)

;(setq x '(a b c d))

(defun isNil (str)
  (if (null str)
    0
    1
  )
)

(print (isNil 1))
;(print (iterf '(a b c d) nil) )
;     (load "testfile.lisp")
;
