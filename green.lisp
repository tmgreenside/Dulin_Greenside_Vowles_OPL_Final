(defun isEven (n)
  (if (/= (rem n 2) 0)
    t
    nil
    )
)

; div by 3 print fizz, div by 5 print buzz, div by 15 print fizz-buzz
; numbers up through 100
(defun fizzbuzz (n)
  (print n)(write-line "")
  (if (= (rem n 3) 0) (write-line "fizz"))
  (if (= (rem n 5) 0) (write-line "buzz"))
  (if (= (rem n 15) 0) (write-line "fizzbuzz"))
  (if (> n 0) (fizzbuzz (- n 1)))
)

; (write (isEven 3))
; (write-line "")

(fizzbuzz 100)

; array of numbers, tell which indexes hold an even number
(defun arrayEven (myList)
  (write (length myList))
)

(defun myRead ()
  (let ((in (open "./sampletext.txt" :if-does-not-exist nil)))
   (when in
      (loop for line = (read-line in nil)
        while line do (format t "~a~%" line))
      (close in)
   )
   )
)

(myRead)

(write-line "Done")
