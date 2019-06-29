{-@ LIQUID "--reflection" @-}
module LogicSolutions where 

import Prelude hiding (length, (++))
{-@ infix ++ @-}


{- 
    ϕ ≡ (∃x.∀y.(p x y)) ⇒ (∀y.∃x.(p x y))
 -}

φ :: (a -> a -> Bool) 
  -> (a, a -> ())
  -> a -> (a, ())

{-@
φ :: p:(a -> a -> Bool) 
  -> (x::a, y:a -> {v:() | p x y})
  -> y:a -> (x::a, {v:() | p x y})
@-}
φ p (x, px) y = (x, px y) 










{- ϕ∃ ≡ (∃x.p x ∨ q x) ⇒ ((∃x.p x) ∨ (∃x.q x))  -}

{-@ 
ϕExists :: p:(a -> Bool) -> q:(a -> Bool)
        -> (x::a, Either {v:() | p x} {v:() | q x})
        -> Either (x::a, {v:()| p x}) (x::a, {v:() | q x}) 
  @-}
ϕExists :: (a -> Bool) -> (a -> Bool)
        -> (a, Either () ()) 
        -> Either (a, ()) (a, ())  
ϕExists p q (x, Left  px) = Left  (x, px)
ϕExists p q (x, Right px) = Right (x, px) 


{- ϕ∀ ≡ (∀x.p x ∧ q x) ⇒ ((∀x.p x) ∧ (∀x.q x)) -}

ϕForall :: (a -> Bool) -> (a -> Bool)
        -> (a -> ((), ()))
        -> (a -> (), a -> ()) 

{-@ ϕForall :: p:(a -> Bool) -> q:(a -> Bool)
            -> (x:a -> ({v:() | p x}, {v:() | q x}))
            -> (x:a -> {v:() | p x}, x:a -> {v:() | q x}) 
@-}
ϕForall p q andx = ( \x -> case andx x of {(px, _) -> px}
                   , \x -> case andx x of {(_, qx) -> qx})


{- ∀xs.((∃ys. xs = ys ++ ys) ⇒ (∃n.length xs = n + n))  -}
evenLen :: Eq a => [a] -> ([a], ()) -> (Int, ())
{-@ evenLen :: xs:[a] -> (ys::[a], {v:() | xs == ys ++ ys }) 
            -> (n::Int, {v:() | length xs == n + n}) @-}
evenLen xs (ys, p) = (length ys, const p (ys ++ ys == xs))



{- ϕind ≡ (p 0 ∧ (∀n.p (n − 1) ⇒ p n) ⇒ ∀n.p n) -}
ϕind :: (Int -> Bool) 
     -> ((),(Int -> () -> ()))
     -> Int -> () 
{-@ ϕind :: p:(Int -> Bool) 
         -> ({v:() | p 0},(n:Int -> {v:() | p (n-1)} -> {v:() | p n}))
         -> n:{Int | 0 <= n} -> {v:() | p n} @-}
ϕind p (b,ih) 0 = b
ϕind p (b,ih) n = ih n (ϕind p (b,ih) (n-1))



{-@ measure length @-}
length :: [a] -> Int 
length [] = 0 
length (x:xs) = 1 + length xs 

{-@ reflect ++ @-}
{-@ (++) :: xs:[a] -> ys:[a] -> {zs:[a] | length zs == length xs + length ys} @-}
[] ++ xs = xs 
(y:ys) ++ xs = y:(ys++xs)
