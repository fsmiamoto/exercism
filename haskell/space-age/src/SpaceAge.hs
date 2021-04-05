module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn planet secs = secs / periodInSecsFor planet

periodInSecsFor :: Planet -> Float
periodInSecsFor planet = earthPeriodMultiplierFor planet * earthPeriodInSecs

earthPeriodInSecs :: Num a => a
earthPeriodInSecs = 31557600

earthPeriodMultiplierFor :: Planet -> Float
earthPeriodMultiplierFor Mercury =  0.2408467 
earthPeriodMultiplierFor Venus   =  0.61519726
earthPeriodMultiplierFor Earth   =  1.0       
earthPeriodMultiplierFor Mars    =  1.8808158 
earthPeriodMultiplierFor Jupiter =  11.862615 
earthPeriodMultiplierFor Saturn  =  29.447498 
earthPeriodMultiplierFor Uranus  =  84.016846 
earthPeriodMultiplierFor Neptune =  164.79132 
