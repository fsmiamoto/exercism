# Task 1
# Determines whether or not you need a licence to operate a certain kind of vehicle.
#
# input: {string} kind of vehicle
# output: {boolean} whether a license is required

def needs_license:
    . as $vehicle | ["car", "truck"] | contains([$vehicle])
;

# Task 2
# Helps choosing between two options by recommending the one that
# comes first in dictionary order.
#
# input: {array of strings} options to consider
# output: {string} a sentence of advice which option to choose
def choose_vehicle:
    sort | first | . + " is clearly the better choice."
;

# Task 3
# Calculates an estimate for the price of a used vehicle in the dealership
# based on the original price and the age of the vehicle.
#
# input: {object} with keys "original_price" and "age"
# output: {number} expected resell price in the dealership

def resell_price:
    .original_price as $price 
    | if .age < 3 then .8
        elif .age <= 10 then .7
        else .5
     end 
    | . * $price
;
