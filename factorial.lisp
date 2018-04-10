(defun factorial (n)
  (cond
    ((= n 1) 1)
    (t (* n( factorial (- n 1)))))
)
(print(factorial 4))


(defun fact (N)
  (if (<= n 0)
    1
  (* n (factorial (- n 1)))))


(print(fact 5))


; adds a newline to the end of the file!
(format t "~C~C" #\return #\linefeed)
