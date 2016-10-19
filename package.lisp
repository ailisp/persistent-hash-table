(in-package :cl-user)

(defpackage :persistent-hash-table
  (:use :cl :pht/store)
  (:nicknames :pht)
  (:export
   #:init-phash-table
   #:make-phash-table-store
   #:make-phash-table
   #:phash-table-count
   #:phash-table-rehash-threshold
   #:phash-table-p
   #:make-phash-table
   #:mapphash
   #:getphash
   #:phash-table-size
   #:phash-table-rehash-size
   #:phash-table
   #:remphash
   #:clrphash
   #:with-phash-table-iterator))

(defpackage :persistent-hash-table/store
  (:use cl)
  (:nicknames :pht/store)
  (:export ))
