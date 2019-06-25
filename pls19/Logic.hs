{-@ LIQUID "--reflection" @-}
module Logic where 

{-@ type Prop P = {v:() | P } @-}

{- 
    ϕ ≡ (∃x.∀y.(p x y)) ⇒ (∀y.∃x.(p x y))
 -}

φ :: (a -> a -> Bool) 
  -> (a, a -> ())
  -> a -> (a, ())

{-@
φ :: p:(a -> a -> Bool) 
  -> (x::a, y:a -> {p x y})
  -> y:a -> (x::a, {p x y})
@-}
φ p (x,px) y = (x, px y) 

{- ϕ∃ ≡ (∃x.p x ∨ q x) ⇒ ((∃x.p x) ∨ (∃x.q x))  -}

{-@ 
ϕExists :: p:(a -> Bool) -> q:(a -> Bool)
        -> (x::a, Either {p x} {q x})
        -> Either (x::a, {p x}) (x::a, {q x}) 
  @-}
ϕExists :: (a -> Bool) -> (a -> Bool)
        -> (a, Either () ()) 
        -> Either (a, ()) (a, ())  
ϕExists p q (x, Left px) = Left (x, px)
-- ϕExists p q (x, Right px) = Left (x, px) 
