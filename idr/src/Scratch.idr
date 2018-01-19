module Main

import Data.Vect

main : IO ()
main = putStrLn "Hello World !"

data Power = Petrol | Pedal

data Vehicle : Power -> Type where
    Bike : Vehicle Pedal
    Car  : (fuel : Nat) -> Vehicle Petrol
    Bus  : (fuel : Nat) -> Vehicle Petrol

go : Vehicle a -> String
go Bike = "Tring tring"
go (Car _) = "Vroom"
go (Bus _) = "Bom"

total refuel : Nat -> Vehicle Petrol -> Vehicle Petrol
refuel k (Car fuel) = Car $ k + fuel
refuel k (Bus fuel) = Bus $ k + fuel
refuel k Bike impossible

zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c
zip f [] [] = []
zip f (x :: xs) (y :: ys) = f x y :: zip f xs ys

tryIndex : Integer -> Vect n a -> Maybe a
tryIndex {n = n} x vect = case integerToFin x n of
    Nothing => Nothing
    Just bound => Just $ index bound vect

readN : IO (Maybe Nat)
readN = do
    x <- getLine
    pure $ Just (the Nat (cast x))
