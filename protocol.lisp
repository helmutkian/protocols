(in-package #:com.helmutkian.protocols)

(defmacro defprotocol (common-args &rest gen-fns)
  `(progn
     ,(loop for gen-fn in gen-fns
	    for name = (first gen-fn)
	    for args = (second gen-fn)
	    for doc = (or (third gen-fn) "")
	    collect `(defgeneric ,name ,(append common-args args)
		       (:documentation ,doc)))))