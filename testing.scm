#!/usr/bin/env gosh

(import
  (scheme base)
  (scheme read)
  (scheme write)
  (scheme load))

(define database
  '(db
    (people
     (name age)
     (string integer)
     ("Alice" 25)
     ("Bob" 50)
     ("Cathy" 15))
    (pets
     (pet-name species owner-name)
     ("Agatha" "bird" "Alice")
     ("Roger" "dog" "Cathy")
     ("Kiddo" "cat" "Alice")
     ("Kudos" "dog" "Ricard"))))

(define people
  (table->alists (assq-ref (cdr database) 'people)))

(define pets
  (table->alists (assq-ref (cdr database) 'pets)))

(define query
  (select
   '(name pet-name)
   (join (lambda (person pet)
           (equal? (assq-ref person 'name)
                   (assq-ref pet 'owner-name)))
         people
         pets)))
