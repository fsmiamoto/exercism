module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year
  | isNotDivisibleBy 4   = False
  | isNotDivisibleBy 100 = True
  | isNotDivisibleBy 400 = False
  | otherwise            = True
  where isNotDivisibleBy x =  year `rem` x /= 0
