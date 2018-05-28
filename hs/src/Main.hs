{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE KindSignatures        #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies          #-}

module Main where

import Data.IntMap (insert, lookup, IntMap, empty)

main :: IO ()
main = putStrLn "hello world"

-- | DataKinds example

data Power = Petrol | Pedal

data Vehicle (a :: Power) where
    Bike  :: Vehicle 'Pedal
    Car   :: Int -> Vehicle 'Petrol
    Bus   :: Int -> Vehicle 'Petrol
    Tesla :: Vehicle a

go :: Vehicle a -> String
go Bike    = "Tring tring"
go (Car _) = "Vroom"
go (Bus _) = "Bom"
go Tesla   = "Eee"

refuel :: Int -> Vehicle 'Petrol -> Vehicle 'Petrol
refuel k (Car fuel) = Car $ k + fuel
refuel k (Bus fuel) = Bus $ k + fuel
refuel _ Tesla      = Tesla

-- | Type families
--
-- https://wiki.haskell.org/GHC/Type_families

class GMapKey k where

    -- > In ordinary Haskell, a type class can associate a set of methods with a
    -- type. The type families extension will now allow us to associate types
    -- with a type.
    -- https://ocharles.org.uk/blog/posts/2014-12-12-type-families.html

    data GMap k :: * -> *

    -- > :k GMap
    -- GMap :: * -> * -> *
    --
    -- There are no constructors defined, so I cannot :t on anything.

    empty       :: GMap k v
    lookup      :: k -> GMap k v -> Maybe v
    insert      :: k -> v -> GMap k v -> GMap k v


instance GMapKey Int where

    data GMap Int v = GMapInt (Data.IntMap.IntMap v)

    empty = GMapInt Data.IntMap.empty
    lookup k   (GMapInt m) = Data.IntMap.lookup k m
    insert k v (GMapInt m) = GMapInt (Data.IntMap.insert k v m)

-- | NullaryTypeClasses! Oh my!
--
-- It's honestly hard to say when this thing is useful. The example with Riemann
-- is cool but not so convincing.
--
-- https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/glasgow_exts.html#nullary-type-classes

class Logger where
    logger :: String -> IO ()

hello :: Logger => [String] -> IO ()
hello xs = mapM_ logger xs
