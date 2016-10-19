

(defvar *storage-dir*  (merge-pathnames ".persistent-hash-table/"
					(user-homedir-pathname)))
(defvar *sync-type* :auto)

(defvar *trac-phash-tables* nil)

(defun generate-phash-table-id ()
  (format nil "~a~a" (get-universal-time) (gensym)))
