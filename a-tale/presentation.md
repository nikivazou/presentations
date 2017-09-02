A tale of two provers
 Liquid Haskell & Coq. 
 
# Is Liquid Haskell a prover? 

(!!) :: xs:[a] -> {i:Int | 0 <= i <= length xs} -> a

[1, 2, 3] !! 2  ( 0 <= 2 <= 3) ~~~> SMT ~~~> OK 
[1, 2, 3] !! 42 ( 0 <= 22 <= 3) ~~~> SMT ~~~> Error 

# 
{-@ parallelismEq :: f:([a] -> [b]) -> Morphism [a] [b] f 
                  -> x:[a] -> i:Pos -> j:Pos
                  -> {f x == pmconcat i (pmap f (chunk j x))} @-}
                  
# 
{-@ parallelismEq :: f:(L a -> L b) -> Morphism (L a) (L b) f 
                  -> x:L a -> i:Pos -> j:Pos
                  -> {f x == pmconcat i (pmap f (chunk j x))} @-}

# 
{-@ parallelismEq :: (Monoid n, ChunkableMonoid m)
                  => f:(m -> n) -> Morphism m n f 
                  -> x:m -> i:Pos -> j:Pos
                  -> {f x == pmconcat i (pmap f (chunk j x))} @-}

# Application:String Matching 

f := toStringMatching :: ByteString -> SM target

data SM (tg :: Symbol) where
SM :: input: RString
→ indices:[GoodIndex input (fromString tg)]
→ SM tg

idLeft :: x:SM t → {ϵ ♦ x = xs}
idRight :: x:SM t → {x ♦ ϵ = x}
assoc :: x:SM t → y:SM t → z:SM t
→ {x ♦ (y ♦ z) = (x ♦ y) ♦ z}


morphismtoSM :: x:RString → y:RString →
{ toSM η = ϵ ∧ toSM (x
y) = toSM x ♦ toSM y}

toSM x == pmconcat i (pmap toSM (chunk j x))


# Summary Numbers (human effort)
I did this proof because (2months)
# Summary Numbers (human effort + Leo 2 weeks)


#Comparison With Coq 

1. Eficient vs. Veried Library Functions
  BS vs. string

2. User-Dened vs. Library Functions
L a vs. list (come with all these lemmata) 

3. SMT- vs. Tactic-Based Automation

Theorem take_spec_list :
∀ i x, i ≤ length_list x →
length_list (drop_list i x) = i.
e crux of the proof is the library lemma size_take.
Lemma size_take x : size (take i x) =
if i < size x then i else size x.

4.  Intrinsic vs. Extrinsic Verication
append


5. Semantic vs. Syntactic Termination Checking
Fixpoint chunkm {M: Type} (fuel : nat)
(i : nat) (x : M) : option (list M)

6. Theorem Prover vs. Proof Assistant
7. Huge vs Tiny TCB

