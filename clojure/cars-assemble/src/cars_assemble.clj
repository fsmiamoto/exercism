(ns cars-assemble)

(def base-rate 221)

(defn sucess-rate [speed]
  (cond (<= speed 4) 1.0
        (<= speed 8) 0.9
        (<= speed 9) 0.8
        :else 0.77
        )
  )

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (* base-rate speed (sucess-rate speed))
  )

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60))
  )

