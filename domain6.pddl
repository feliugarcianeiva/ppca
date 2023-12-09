(define (domain data-network-cloud)
  (:requirements :strips :typing)

  ;; Define types
  (:types server connection database load front back - object)

  ;; Define predicates
  (:predicates
    (connected ?d1 - server ?d2 - server)
    (link-available ?c - connection)
    (database-connected ?d1 - server - ?db1 - database)
    (front-ended ?d1 - server - ?db1 - database - ?fe - front)
    (back-ended  ?d1 - server - ?db1 - database - ?fe - front - ?be - back)
    (data-loaded ?lo - load )
  )

  ;; Define numeric fluents for process costs
  (:functions
    (total-cost)
  )

  ;; Define actions
  (:action connect
    :parameters (?d1 - server ?d2 - server ?c - connection)
    :precondition (and (not (connected ?d1 ?d2)) (link-available ?c))
    :effect (and (connected ?d1 ?d2) (increase (total-cost) 1))
  )

  (:action disconnect
    :parameters (?d1 - server ?d2 - server ?c - connection)
    :precondition (connected ?d1 ?d2)
    :effect (and (not (connected ?d1 ?d2)) (increase (total-cost) 2))
  )

  (:action connect-database
    :parameters (?d - server ?db - database)
    :precondition (and (connected ?d ?db) (not (database-connected ?db)))
    :effect (and (database-connected ?db) (increase (total-cost) 4))
  )

  (:action disconnect-database
    :parameters (?d - server ?db - database)
    :precondition (and (connected ?d ?db) (not (database-connected ?db)))
    :effect (and (not (database-connected ?db)) (increase (total-cost) 4))
  )

  (:action load-data
    :parameters (?d - server ?db - database)
    :precondition (and (connected ?d ?db)  (database-connected ?db))
    :effect (and (not (data-loaded ?lo)) (increase (total-cost) 2))
  )

  (:action front-end
    :parameters (?d - server ?db - database)
    :precondition (and (front-ended ?fe) (connected ?d ?db)  (database-connected ?db))
    :effect (and (not (data-loaded ?lo)) (increase (total-cost) 2))
  )

)
