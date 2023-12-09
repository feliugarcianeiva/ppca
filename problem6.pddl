(define (problem data-network-problem)
  (:domain data-network-cloud)

  ;; Define objects
  (:objects
    C1 C2 C3 C4 C5 - connection
    FE1 FE2 - front
    BE1 BD2 - back
    D1 D2 D3 D4 D5 D6 - server
    DB1 DB2 - database
  )

  ;; Define initial state
  (:init
    (link-available C5)
    (link-available C1 C2)
    (link-available C3 C4)
    (front-ended FE1 FE2)
    (back-ended BE1 BE2)
    (connected D1 D2 D3 D4)
    (connected D1 D4 D5 D6)
    (connected D2 D3 D5)
    (database-connected DB1)
    (database-connected DB2)
    (data-loaded LO1)
    (data-loaded LO3)
    (not (connectd D6))
    (= (total-co st) 0)
  )

  ;; Define goal state
  (:goal
    (and
      (connected D1 D2)
      (connected D1 D3)
      (connected D1 D4)
      (connected D3 D4)
      (not (connected D3 D5))
      (database-connected DB1)
      (data-loaded LO1)
      (database-connected DB2)
    )
  )
  (:metric
     minimize (total-cost)
  )
)
