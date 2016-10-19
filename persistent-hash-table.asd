(defsystem :persistent-hash-table
  :description "A fast persistent hash table in Common Lisp"
  :author "Bo Yao <icerove@gmail.com>"
  :license "BSD"
  :depends-on (:alexandria :exit-hooks :cl-fad)
  :serial t 
  :components ((:file "package")
	       (:file "util")
	       (:module "store"
			:components
			((:file "base-store")
			 (:file "dir-store" :depends-on ("base-store"))))
	       (:file "persistent-hash-table")))
