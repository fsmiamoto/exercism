module Pangram (isPangram) where

import Data.Char (isLetter, toLower)

letters :: String
letters = ['a'..'z']

isPangram :: String -> Bool
isPangram ""  = False
isPangram text = length filtered == 0 
    where filtered = filterBy letters (normalize text)

filterBy :: String -> String -> String
filterBy ls [] = ls
filterBy ls (m:ms) = filterBy (filter (\l -> l /= m) ls) ms

removeNonLetters :: String -> String
removeNonLetters = filter isLetter

toLowerCase :: String -> String
toLowerCase = map toLower

normalize :: String -> String
normalize = removeNonLetters . toLowerCase

