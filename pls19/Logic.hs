{-@ LIQUID "--reflection" @-}
module Logic where 

import Prelude hiding (length, (++))
{-@ infix ++ @-}



divTest :: Int 
divTest = 42 `div` 10








{- 
    ϕ ≡ (∃x.∀y.(p x y)) ⇒ (∀y.∃x.(p x y))
 -}

{-@
φ :: p:(a -> a -> Bool) 
  -> (x::a, y:a -> {v:() | p x y})
  -> y:a -> (x::a, {v:() | p x y})
@-}
φ p (x, px) y = undefined 





{- ϕ∃ ≡ (∃x.p x ∨ q x) ⇒ ((∃x.p x) ∨ (∃x.q x))  -}

{-@ 
ϕExists :: p:(a -> Bool) -> q:(a -> Bool)
        -> (x::a, Either {v:() | p x} {v:() | q x})
        -> Either (x::a, {v:() | p x}) (x::a, {v:() | q x}) 
  @-}
ϕExists p q _ = undefined 




{- ϕ∀ ≡ (∀x.p x ∧ q x) ⇒ ((∀x.p x) ∧ (∀x.q x)) -}


{-@ ϕForall :: p:(a -> Bool) -> q:(a -> Bool)
            -> (x:a -> ({v:() | p x}, {v:() | q x}))
            -> (x:a -> {v:() | p x}, x:a -> {v:() | q x}) 
@-}
ϕForall p q prop = undefined 






{- ∀xs.((∃ys. xs = ys ++ ys) ⇒ (∃n.length xs = n + n))  -}
{-@ evenLen :: xs:[a] -> (ys::[a], {v:() | xs == ys ++ ys }) 
            -> (n::Int, {v:() | length xs == n + n}) @-}
evenLen xs (ys, prop) = undefined 





{-@ helper :: xs:[a] -> ys:[a] 
           -> { length (xs ++ ys) = length xs + length ys } @-}
helper xs ys = const () (xs ++ ys)








{- ϕind ≡ (p 0 ∧ (∀n.p (n − 1) ⇒ p n) ⇒ ∀n.p n) -}
{-@ ϕind :: p:(Int -> Bool) 
         -> ({v:() | p 0},(n:Int -> {v:() | p (n-1)} -> {v:() | p n}))
         -> n:{Int | 0 <= n} -> {v:() | p n} @-}
ϕind = undefined 












-------------------------------------------------------------------------------
-- Signatures ----------------------------------------------------------------- 
-------------------------------------------------------------------------------

φ :: (a -> a -> Bool) 
  -> (a, a -> ())
  -> a -> (a, ())

ϕExists :: (a -> Bool) -> (a -> Bool)
        -> (a, Either () ()) 
        -> Either (a, ()) (a, ())  


ϕForall :: (a -> Bool) -> (a -> Bool)
        -> (a -> ((), ()))
        -> (a -> (), a -> ()) 

evenLen :: Eq a => [a] -> ([a], ()) -> (Int, ())
helper :: [a] -> [a] -> ()

ϕind :: (Int -> Bool) 
     -> ((),(Int -> () -> ()))
     -> Int -> () 

-------------------------------------------------------------------------------
-- Helpers -------------------------------------------------------------------- 
-------------------------------------------------------------------------------

{-@ measure length @-}
length :: [a] -> Int 
length [] = 0 
length (x:xs) = 1 + length xs 

{-@ reflect ++ @-}
{-@ (++) :: xs:[a] -> ys:[a] -> {zs:[a] | length zs == length xs + length ys} @-}
[] ++ xs = xs 
(y:ys) ++ xs = y:(ys++xs)
