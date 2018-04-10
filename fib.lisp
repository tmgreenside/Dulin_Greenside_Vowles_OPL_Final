;freaking lisp! All by myself lol

(defun fib(n)
  (if (>= 2 n)
    1
  ;(* n 2))
(+ (fib (- n 1)) (fib (- n 2))))
)

;;is the number an even fibanocci number?
(defun isFibEven(n)
  (if (= (mod (fib n) 2) 0 )
    t
  nil
  )
)

(defun count-fib-helper(n count)
  (if (= n 0)
    count
  (if (isFibEven n )
    (count-fib-helper (- n 1) (+ count 1))
  (count-fib-helper (- n 1) (+ count )))))

; finds nth fib number. NOT GOOD WITH large numbers lol.
(defun count-fib (x)
  (count-fib-helper x 0))

(print "Number of fib sequences under x")
(print (count-fib 30))

; adds a newline to the end of the file!
(format t "~C~C" #\return #\linefeed)
