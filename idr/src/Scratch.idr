module Main

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

refuel : Nat -> Vehicle Petrol -> Vehicle Petrol
refuel k (Car fuel) = Car $ k + fuel
refuel k (Bus fuel) = Car $ k + fuel
