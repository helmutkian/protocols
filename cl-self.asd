
(in-package #:asdf)

(defsystem #:com.helmutkian.cl-self
  :components ((:system "parse-declarations-1.0")
	       (:system "alexandria")
	       (:file "package"
		      :depends-on ("parse-declarations-1.0"
				   "alexandria"))
	       (:file "self"
		      :depends-on ("package"))))

