(in-package :pht)

(defvar *storage-dir* #P"/tmp/pht")

(defvar *sync-type* :auto)

(defun init-phash-table (&key (dir nil) (sync nil))
)

(defclass persistent-hash-table ()
  ((internal-hash-table :accessor :internal-hash-table :initarg :internal-hash-table)
   (internal-id :accessor :interal-id :initarg :internal-id)))
