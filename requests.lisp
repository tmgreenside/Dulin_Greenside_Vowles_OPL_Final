(load "~/quicklisp/setup.lisp")
(ql:quickload "dexador")
(ql:quickload :cl-ppcre)

(defvar *url* "https://lispcookbook.github.io/cl-cookbook/")
(defvar *request* (dex:get *url*))

;(print *request*)

(defvar *max* (cl-ppcre:scan-to-strings "href=[\'\"]?([^\'\" >]+)" *request*))
(print *max*)
