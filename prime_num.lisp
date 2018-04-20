;finding primes numbers!
(defun prime_num_helper (x n)
  (if (>= (expt n 0.5) x)
    (if (= (mod n x) 0)
      nil
      (prime_num_helper (+ x 1) n))
  t)
)

; n is the number to check
;checks to see if a number is prime or not
(defun is_prime (n)
  (prime_num_helper 2 n)
)


(defun prime_range_helper_ending(bottom top div list_fun)
  (if (<= bottom top)
    (if(and (is_prime bottom) (/= (mod bottom 10) div))
      (prime_range_helper_ending (+ bottom 1) top div (cons bottom list_fun))
    (prime_range_helper_ending (+ bottom 1) top div list_fun))
  list_fun)
)

;; returns all but the last item in the list
(defun without-last(l)
    (reverse (cdr (reverse l)))
)

; returns a range of prime numbers, without the particular number at the end
;
(defun prime_range(bottom top div)
  (without-last(prime_range_helper_ending bottom top div (list ())))
)


(print (prime_range 67 1000 7))



; adds a newline to the end of the file!
(format t "~C~C" #\return #\linefeed)
