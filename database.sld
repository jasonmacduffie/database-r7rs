(define-library (macduffie database)
  (import (scheme base) (srfi 1))
  (export assq-ref select join table->alists insert-into!
          update-row! update-table! select-table)
  (include "./database.body.scm"))
