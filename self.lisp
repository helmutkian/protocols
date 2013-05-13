(in-package #:com.helmutkian.cl-self)

;;; Utils from PG's "On Lisp"

	      
(defun rmapcar (fn &rest args)
  (if (some #'atom args)
      (apply fn args)
      (apply #'mapcar
	     (lambda (&rest args)
	       (apply #'rmapcar fn args))
	     args)))

(defun explode (sym)
  (map 'list
       (lambda (c)
	 (intern (make-string 1 :initial-element c)))
       (symbol-name sym)))


;;; Expanders

(defun expand-accessor (accessor)
  "Expands to the function application form used for
   accessors and readers."
  `(,accessor self))

(defun expand-slot (slot)
  "Expands to a call to SLOT-VALUE to reference specified
   slot."
  `(slot-value self ',slot))


(defun expand-method-body (body)
  "Expands symbols prefixed with @ or $ to accessor or slot form 
   respectively"
  (rmapcar (lambda (x)
	     (let ((sym (when (symbolp x) (explode x))))
	       (cond
		 ;; expand "accessor": @sym => (sym self)
		 ((and sym (eql (car sym) '@))
		  (expand-accessor (apply #'symbolicate (cdr sym))))
		 ;; expand "slot": $sym => (slot-value self 'sym)
		 ((and sym (eql (car sym) '$))
		  (expand-slot (apply #'symbolicate (cdr sym))))
		 ;; expand else: sym => sym
		 (t 
		  x))))
	       body))


;;; Macro

(defun parse-method-definition (method-def)
  "Parses the method definition into name, combination specifier,
   arg list, declarations, docstring, and body returned as VALUES
   in that order."
  (let* ((name (pop method-def))
	 (combo 
	  (when (symbolp (car method-def))
	    (pop method-def)))
	 (args (pop method-def)))
    (multiple-value-bind (body decls docstr) (parse-body method-def)
      (values name
	      combo
	      args
	      decls
	      docstr
	      body))))


(defmacro defmethod* (&body body)
  (multiple-value-bind  (name combo args decls docstr meth-body)
      (parse-method-definition body)
    (remove nil
	    `(defmethod ,name ,combo ,args
			,docstr
			,@decls
		        ,@(expand-method-body meth-body)))))
