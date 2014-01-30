protocols
=========

Utilities that make CLOS behave more like traditional OOP.

========

(DEFPROTOCOL (&optional common-args) (generic-fn-name generic-fn-args &optional docstring*) ...)

common-args -- Arguments common to each generic function in the protocol. These will be the first arguments, and the arguments specified elsewhere will be appended to them.

generic-fn-name -- Name of the generic function
generic-fn-args -- Arguments specific to that generic function, appended to the end of common-args.
docstring -- Optional docstring

Example:

(defprotocol (my-arg your-arg)
  (f1 (arg1) "Example function 1")
  (f2 (arg2 &key key1 key2)))
  
=>

(defgeneric f1 (my-arg your-arg arg1)
  (:documentation "Example function 1"))
  
(defgeneric f2 (my-arg your-arg arg2 &key key1 key2))

========

DEFMETHOD* behaves exactly like DEFMETHOD, but if one its arguments are named SELF it allows for easy access to slots and accessors with the sigils $ and @ respecitively.

Example:

(defclass foo ()
  (x)
  (y :accessor y))

(defmethod* add ((self foo) (num number))
  (+ $x @y num))
  
=>

(defmethod add ((self foo) (num number))
  (+ (slot-value self 'x) (y self) num))
