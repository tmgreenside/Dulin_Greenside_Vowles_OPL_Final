; This program will read text from file "sampletext.txt" and extract all
; words starting with the letter 'm' or 'M'

(defun myRead ()
  (let (result "")
  (let ((in (open "./sampletext.txt" :if-does-not-exist nil)))
   (when in
      (loop for line = (read-line in nil)
        while line do (concatenate 'string result item))
      (close in)
   )
  )
  result
)

(defvar x (myRead))
(write-line "Here we go")

(write x)
