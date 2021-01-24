module LeapYear (isLeapYear) where

isNotDivisibleBy :: Integer -> Integer -> Bool
isNotDivisibleBy x = \a -> a `mod` x /= 0

isLeapYear :: Integer -> Bool
isLeapYear year
  | isNotDivisibleBy 4   year = False
  | isNotDivisibleBy 100 year = True
  | isNotDivisibleBy 400 year = False
  | otherwise                 = True
