(require "asdf")

;(asdf:run-shell-command "wget http://www.cs.gonzaga.edu/faculty/depalma/courses/cpsc427/asgnS18/proj9.pdf") ; runs, now need to collect output

(defun getStuffFromLink (link)
  (asdf:run-shell-command (concatenate 'string "wget " link))
)

(getStuffFromLink "http://www.cs.gonzaga.edu/faculty/depalma/courses/cpsc427/asgnS18/proj8.html")
