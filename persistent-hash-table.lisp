(in-package :pht)

;;;; init config

(defun init-phash-table-store (&key (dir nil) (sync nil))
  (unless dir
    (setf *storage-dir* (pathname dir)))
  (unless sync
    (setf *storage-dir* sync))
  (ecase sync
    (:auto)
    (:exit (exit-hooks:add-exit-hook #'write-phash-tables))))

;;;; phash-table definition and construct function

(defclass phash-table ()
  ((internal-hash-table :accessor :internal-hash-table :initarg :internal-hash-table)
   (internal-id :accessor :interal-id :initform (generate-phash-table-id))))

(defun make-phash-table (&key test size rehash-size rehash-threshold)
  (make-instance 'phash-table :internal-hash-table
		 (make-hash-table :test test :size size :rehash-size rehash-size :rehash-threshold rehash-threshold)))

;;;; trivial compartible layer to cl:hash-table

(defun phash-table-count (phash-table)
  (hash-table-count (internal-hash-table phash-table)))

(defun phash-table-rehash-threshold (phash-table)
  (hash-table-rehash-threshold (internal-hash-table phash-table)))

(defun phash-table-p (phash-table)
  (typep phash-table 'phash-table))

(defun mapphash (func phash-table)
  (maphash func (internal-hash-table phash-table)))

(defun phash-table-size (phash-table)
  (hash-table-size (internal-hash-table phash-table)))

(defun phash-table-rehash-size (phash-table)
  (hash-table-size (internal-hash-table phash-table)))

(defun phash-table-test (phash-table)
  (hash-table-test (internal-hash-table phash-table)))

(defmacro with-phash-table-interator ((name phash-table) &body body)
  (with-hash-table-iterator (,name ,(internal-hash-table phash-table))
    ,@body))

;;;; phash-table implementation

(defun getphash (key phash-table &optional default)
  (gethash key (internal-hash-table phash-table)))

(defun remphash (key phash-table)
  (remhash key (internal-hash-table phash-table)))

(defun clrphash (phash-table)
  (clrhash (internal-hash-table phash-table)))

(defun write-phash-tables ()
  (dolist (phash-table *trac-phash-tables*)
    (write-phash-table phash-table)))

(defun write-phash-table (phash-table)
  (with-open-file (s (merge-pathnames (internal-id phash-table)
				      *storage-dir*)
		     :direction :output :if-exists :supersede)
    (mapphash #'(lambda (key value)
		  (format s "~s ~s~%" key value)))))

(defun write-phash-table-item (phash-table key value)
  (with-open-file (s (merge-pathnames (internal-id phash-table)
				      *storage-dir*)
		     :direction :output :if-exists :append)
    (format s "~s ~s~%" key value)))
