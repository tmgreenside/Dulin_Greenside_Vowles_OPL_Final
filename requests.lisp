;;; How to run:
;;; 1. open sbcl (steel bank common lisp)
;;; 2.0 Ensure that quicklisp is installed. Further, download dexador and cl-ppcre
;;; 2.1 Type: (load "requests.lisp") into the command line
;;; 3. Watch the magic happen!

(load "~/quicklisp/setup.lisp") ;package installer for lisp
(ql:quickload "dexador") ;for get requests
(ql:quickload :cl-ppcre) ;for regex
(require "asdf")


;gets the physical page from the website
(defun get_page (request)
  (dex:get request)
)

;gets all links from a page
;returns a list of strings that are lists.
(defun get_all_links (page)
  ; could get this to work with src also.
  (cl-ppcre:all-matches-as-strings "(src|href)=[\'\"]?([^\'\" >]+)" (get_page page))
)

; gets all of the mail to links out of the page
(defun getmailto (links_list mail_to_links)
  (if (null links_list)
    mail_to_links ; empty list

  (if (< (isNil (cl-ppcre:scan "mailto:" (first links_list))) 1)
    (getmailto
      (cdr links_list) mail_to_links)

    (getmailto (cdr links_list)
      (push (subseq (first links_list) 6) mail_to_links))
  ))
)

; gets all of the mail to links out of the page then removes them.
(defun notgetmailto (links_list not_mail_to_links)
  (if (null links_list)
    not_mail_to_links ; empty list

  (if (< (isNil (cl-ppcre:scan "mailto:" (first links_list))) 1)
    (notgetmailto (cdr links_list)
        (push (first links_list) not_mail_to_links))
    (notgetmailto
      (cdr links_list) not_mail_to_links)
  ))
)


; page is the page being searched
; base is the base set of the page
; links_list is the full list of what was taken from the website
; holy sh**, this works... and we hate lisp
(defun get_all_links_full (page base links_list fixed_links)
  (if (null links_list)
    fixed_links ; empty list

  ;; had an issue with the remove_prefix function. But, didn't want to nest ifs. So, it's fixed later on.
  (if (< (isNil (cl-ppcre:scan "ttp" (remove_prefix (first links_list)))) 1 )

    (get_all_links_full page base
      (cdr links_list)
      (push (concatenate 'string base
      (remove_prefix (first links_list)))
      fixed_links))

    (get_all_links_full page base
      (cdr links_list) (push
      (remove_prefix (first links_list))
      fixed_links))
  ))
)

; Appends a line to a file
(defun myWrite (line fileout)
  (with-open-file (stream fileout :direction :output :if-exists :append :if-does-not-exist :create)
    (format stream line)
    (format stream "~%")
  )
)

; eliminates content from a passed-in file
(defun myClear (filename)
  (with-open-file (stream filename :direction :output :if-exists :supersede))
)

; gets all jpg, png, pdf, and gif files from a site by means of the
; getResource helper function.
(defun getAllResources (linkListFile)
  (let ((in (open linkListFile :if-does-not-exist nil)))
   (when in
    (loop for line = (read-line in nil)
      while line do (getResource line))
    (close in)
    (write-line "")
   )
  )
)

; helper function for the getAllResources function above.
(defun getResource (line)
  (if (= (isNil (cl-ppcre:scan ".jpg|.png|.pdf|.gif" line)) 1)
    (print line)
    ;(asdf:run-shell-command (concatenate 'string "wget " line))
    nil
  )
)

;; returns 0 if the list is nil, 1 otherwise
;src, mail,
(defun isNil (str)
  ;; this is sick! Nil is the empty list when returned!
  (if (null str)
    0
    1)
)

; Prints a list of links to the terminal
(defun print_list (links)
  (if (null links)
    nil
    (print (first links))
  )
  (if (null (cdr links))
      nil
  (print_list (cdr links))
  )
)

; removes the prefix of the list
(defun remove_prefix (my_string)
  (subseq my_string 6)
)

; adds 'h' to strings beginning with "ttps"
;returns a list of strings of all links - those with "ttps" now include "https"
(defun addH (links_list fixed_links)
  (if (null links_list)
    fixed_links ; empty list

  (if (< (isNil (cl-ppcre:scan "^ttp" (first links_list))) 1 )
    (addH (cdr links_list)
      (push (first links_list)
      fixed_links))
    (addH (cdr links_list)
      (push (concatenate 'string "h" (first links_list)) fixed_links))
  ))
)


;;;;;;
; Gets all of the links, mailto-links from the website
;;;;;;
; base domain of the website
(setq base "https://css-tricks.com/")
(setq page "https://css-tricks.com/snippets/html/mailto-links/")
(setq links (get_all_links page))

(setq edit_linked (notgetmailto links nil))
(setq mailto (getmailto links nil))

(setq fixed_links1 (get_all_links_full page base edit_linked nil))
(setq final (addH fixed_links1 nil))
(print_list final)

;;; Pings the server
(if (= (isNil (asdf:run-shell-command "ping https://www.tutorialspoint.com/")) 1)
  (print "It is up")
  (print "The server is down")
)

;;writes the links to a file
(myClear "links.txt")
(loop for link in final
  do (myWrite link "links.txt")
)
(loop for link in mailto
  do (myWrite link "links.txt")
)

;; Gets all of the pictures
(getAllResources "links.txt")
