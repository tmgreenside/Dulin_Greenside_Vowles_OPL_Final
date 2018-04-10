

(print(+ 1 34))

(setf x (* 3 2))
; semi colons are comments
(print(<= 4 3))

;essentially a four loop!
; runs 4 times, which prints hello, then returns yo!
(dotimes (x 4 "yo")(print "hello"))


; adds a newline to the end of the file!
(format t "~C~C" #\return #\linefeed)
