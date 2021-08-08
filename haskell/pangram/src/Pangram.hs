module Pangram (isPangram) where

import Data.Char (toLower, isAsciiLower)
import Data.List (sort, group)

isPangram :: String -> Bool
isPangram text = l == 26 where l = length $ (group . sort) $ normalize text

normalize :: String -> String
normalize = filter isAsciiLower . map toLower

