; This program will read text from file "sampletext.txt" and extract all
; words starting with the letter 'm' or 'M'

(defun myRead ()
  (let ((in (open "./sampletext.txt" :if-does-not-exist nil)))
   (when in
      (loop for line = (read-line in nil)
        while line do (printLine line))
      (close in)
      (write-line "")
   )
  )
)

(defun printLine (line)
  (print line)
)

; given a list of strings, print to terminal and write to a file
(defun myWrite (line)
  (with-open-file (stream "myout.txt" :direction :output :if-exists :append :if-does-not-exist :create)
    (format stream line)
  )
)

(defun myClear (filename)
  (with-open-file (stream filename :direction :output :if-exists :supersede))
)

(defun myWriteList (lines)
  (with-open-file (stream "myout.txt" :direction :output :if-exists :append :if-does-not-exist :create)
    (loop for line = (read-line lines)
      while line do (printLine line)
    )
  )
)

(myWriteList "else")
