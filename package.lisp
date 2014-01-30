
(defpackage #:com.helmutkian.protocols
  (:nicknames #:protocols)
  (:use #:common-lisp)
  (:import-from #:tcr.parse-declarations-1.0
		#:parse-body)
  (:import-from #:alexandria
		#:symbolicate)
  (:export #:defprotocol
           #:defmethod*))
