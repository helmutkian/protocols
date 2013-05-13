
(defpackage #:com.helmutkian.cl-self
  (:nicknames #:cl-self)
  (:use #:common-lisp)
  (:import-from #:tcr.parse-declarations-1.0
		#:parse-body)
  (:import-from #:alexandria
		#:symbolicate)
  (:export #:defmethod*))
