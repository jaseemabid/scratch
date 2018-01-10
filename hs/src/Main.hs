{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}

module Main where

main :: IO ()
main = putStrLn "hello world"


data Power = Petrol | Pedal

data Vehicle (a :: Power) where
    Bike  :: Vehicle Pedal
    Car   :: Int -> Vehicle Petrol
    Bus   :: Int -> Vehicle Petrol
    Tesla :: Vehicle a

go :: Vehicle a -> String
go Bike = "Tring tring"
go (Car fuel) = "Vroom"
go (Bus fuel) = "Bom"

refuel :: Int -> Vehicle Petrol -> Vehicle Petrol
refuel k (Car fuel) = Car $ k + fuel
refuel k (Bus fuel) = Car $ k + fuel
