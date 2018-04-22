(load "~/quicklisp/setup.lisp") ;package installer for lisp
(ql:quickload "dexador") ;for get requests
(ql:quickload :cl-ppcre) ;for regex


;https://edicl.github.io/cl-ppcre/
;gets the physical page from the website
(defun get_page (request)
  (dex:get request)
)

;gets all links from a page
;this is a list of values!
(defun get_all_links (page)
  (cl-ppcre:all-matches-as-strings "href=[\'\"]?([^\'\" >]+)" (get_page page))
)

; page is the page being searched
; base is the base set of the page
; links_list is the full list of what was taken from the website
(defun get_all_links_full (page base links_list)
  (if (null links_list)
    links_list ; empty list

    ;;most of this works! just have an issue with iterating through the list, then adding the list at the end. So, then to figure that out!
  (if (<= (cl-ppcre:scan "www" (remove_prefix (first links_list))) 1 )
    (append (concatenate 'string base (remove_prefix (first links_list))) (get_all_links_full page base (cdr links_list)))
    (append (remove_prefix (first links_list)) (get_all_links_full page base (cdr links_list)))
  ))
)

; removes the prefix of the list
(defun remove_prefix (my_string)
  (subseq my_string 6)
)

;    (load "requests.lisp")
;    ("href=\"/favicon.ico"


;***************************;
;Don't delete this print line! IT is for the function get_all_links_full that is currently broken

;(print (get_all_links_full "https://www.tutorialspoint.com/lisp/lisp_functions.htm" "https://www.tutorialspoint.com" (get_all_links "https://www.tutorialspoint.com/lisp/lisp_functions.htm")))
