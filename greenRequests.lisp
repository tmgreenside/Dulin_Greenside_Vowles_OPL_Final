(load "~/quicklisp/setup.lisp") ;package installer for lisp
(ql:quickload "dexador") ;for get requests
(ql:quickload :cl-ppcre) ;for regex

(require "asdf") ; for using command line tools

; saves the resource in the link to the file system
(defun getStuffFromLink (link)
  (asdf:run-shell-command (concatenate 'string "wget " link))
)


;https://edicl.github.io/cl-ppcre/
;gets the physical page from the website
(defun get_page (request)
  (dex:get request)
)

;gets all links from a page
;returns a list of strings that are lists.
(defun get_all_links (page)
  (cl-ppcre:all-matches-as-strings "href=[\'\"]?([^\'\" >]+)" (get_page page))
)

; page is the page being searched
; base is the base set of the page
; links_list is the full list of what was taken from the website
;holy shit, this works... and we hate lisp
(defun get_all_links_full (page base links_list fixed_links)
  (if (null links_list)
    fixed_links ; empty list

  (if (< (isNil (cl-ppcre:scan "http" (remove_prefix (first links_list)))) 1 )

    (get_all_links_full page base (cdr links_list) (push (concatenate 'string base (remove_prefix (first links_list))) fixed_links))

    (get_all_links_full page base (cdr links_list) (push (remove_prefix (first links_list)) fixed_links))

  ))
)

(defun get_everything (page base links_list fixed_links)
  (if (null links_list)
    fixed_links ; empty list

  (if (< (isNil (cl-ppcre:scan "http" (remove_prefix (first links_list)))) 1 )

    (get_all_links_full page base (cdr links_list) (push (concatenate 'string base (remove_prefix (first links_list))) fixed_links))

    (get_all_links_full page base (cdr links_list) (push (remove_prefix (first links_list)) fixed_links))

  ))
)


;; returns 0 if the list is nil, 1 otherwise
;src, mail,
(defun isNil (str)
  (if (null str)
    0
    1)
)

; removes the prefix of the list
(defun remove_prefix (my_string)
  (subseq my_string 6)
)

;    (load "requests.lisp")
;    ("href=\"/favicon.ico"


;***************************;
;Don't delete this print line! IT is for the function get_all_links_full that is currently broken

(print (get_all_links_full "https://www.tutorialspoint.com/lisp/lisp_functions.htm" "https://www.tutorialspoint.com" (get_all_links "https://www.tutorialspoint.com/lisp/lisp_functions.htm") nil ))
