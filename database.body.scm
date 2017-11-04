
(define (assq-ref al key)
  (cdr (assq key al)))

(define (select keys list-of-alists)
  (map (lambda (al)
         (if (eq? keys '*)
             al
             (map (lambda (key)
                    (cons key (assq-ref al key)))
                  keys)))
       list-of-alists))

(define (join pred la lb)
  (let a-loop ((in-a la)
               (out-ab '()))
    (if (null? in-a)
        out-ab
        (let b-loop ((in-b lb)
                     (out-b out-ab))
          (if (null? in-b)
              (a-loop (cdr in-a) out-b)
              (b-loop (cdr in-b)
                      (if (pred (car in-a)
                                (car in-b))
                          (cons (append (car in-a)
                                        (car in-b))
                                out-b)
                          out-b)))))))

(define (table->alists t)
  (define column-names (car t))
  (define table-body (cddr t))
  (map (lambda (row)
         (map (lambda (name col)
                (cons name col))
              column-names
              row))
       table-body))

(define (insert-rows! t als)
  (define column-names (car t))
  (define new-rows
    (map (lambda (al)
           (map cdr al))
         (select column-names als)))
  (set-cdr! (cdr t)
            (append new-rows (cddr t))))

(define (insert-into! db tb als)
  (define table (select-table db tb))
  (insert-rows! table als))

(define (update-row! col-names old-row value-al)
  (for-each (lambda (p)
              (list-set!
               old-row
               (list-index (lambda (name)
                             (eq? name (car p)))
                           col-names)
               (cdr p)))
            value-al))

(define (update-table! db tb proc)
  (define table (select-table db tb))
  (define (row-mapping! row)
    (update-row! (car table)
                 row
                 (proc (map cons
                            (car table)
                            row))))
   (for-each row-mapping! (cddr table)))

(define (select-table db tb)
  (assq-ref (cdr db) tb))

(define (load-database path)
  (let ((p (open-input-file path)))
    (let ((result (read p)))
      (close-input-port p)
      result)))

