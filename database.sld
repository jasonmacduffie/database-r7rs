(define-library (macduffie database)
  (import
    (scheme base)
    (scheme file)
    (scheme read)
    (scheme write)
    (srfi 1))
  (export assq-ref select join table->alists insert-into!
          update-row! update-table! select-table load-database
          write-database)
  (include "./database.body.scm"))
