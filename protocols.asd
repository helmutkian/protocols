(asdf:defsystem #:protocols
  :depends-on ("parse-declarations-1.0" "alexandria")
  :components ((:file "package"
		      :depends-on ("parse-declarations-1.0"
				   "alexandria"))
	       (:file "self"
		      :depends-on ("package"))
	       (:file "protocol"
		      :depends-on ("package"))))

