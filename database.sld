(define-library (macduffie database)
  (import
    (scheme base)
    (scheme file)
    (scheme read)
    (srfi 1))
  (export assq-ref select join table->alists insert-into!
          update-row! update-table! select-table load-database)
  (include "./database.body.scm"))
