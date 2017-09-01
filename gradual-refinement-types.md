In Theory 
---------


# Refinement Types 
(/):: Int -> Int -> Int 
(/):: Int -> {v:Int |0 < v} -> Int 

#Program
isNat :: x:Int -> {v:Bool | v <=> 0 <= x}
isNat x = 0 <= x 
divIf x = if (isNat x) then 1/(1+x) else 1/(-x)

isSafe?

#SubTyping 
x:Int, {b:Bool| b <=> 0 <= x && b}     |= {v:Int v = 1+x} <: {v:Int | 0 < v } 
x:Int, {b:Bool| b <=> 0 <= x && not b} |= {v:Int v = -x}  <: {v:Int | 0 < v } 

isSafe? <= isSubTy? 

#VC 
true, b <=> 0 <= x && b     => v = 1+x  => 0 < v
true, b <=> 0 <= x && not b => v = -x   => 0 < v 
isSafe? <= isSubTy? <= isValid?


#Program
isNat: library unrefined function 

a :: x:Int -> Bool
divIf :: Int -> Int
divIf x = if (a x) then 1/(1+x) else 1/(-x)
                          0 <= x      x < 0     


divIf :: {v:Int | ? } -> Int
#SubTyping 
x:{v:Int | ?}, {b:Bool| b}     |= {v:Int v = 1+x} <: {v:Int | v /= 0} 
x:{v:Int | ?}, {b:Bool| not b} |= {v:Int v = -x}  <: {v:Int | v /= 0} 

isSafe? <= isSubTy? 
#Abstract Gradual Types TILDA 

#VC 
exists p. p x, b     => v = 1+x  => v /= 0
exists p. p x, not b => v = -x   => v /= 0 



# Gradual Refinement Types
In Theory 
  - More expressive 
  - Gradual Program migration 
isSafe? <= isSubTy?TILDA_ <= isValid?

Problem: Implementation of existential.
In Practise?


In Practise 
-----------

# Implementation 
VC checking has existential 
Problem: Domain is infinite 
Solution: Make Domain Finite. 

# Solution: Refinement Typing with Finite Domain

# Liquid Types: Example

* <=> true 
* <=> false 
0 <= * 
* < 0 
* <=> (0 <= *) 

isNat :: x:Int -> {v:Bool | k }
isNat x = 0 <= x 
divIf x = if (isNat x) then 1/(1+x) else 1/(-x)

#SubTyping 
x:Int |= v <=> 0 <= x  <: k v  
x:Int, {b:Bool| k b && b}     |= {v:Int v = 1+x} <: {v:Int | 0 < v } 
x:Int, {b:Bool| k b && not b} |= {v:Int v = -x}  <: {v:Int | 0 < v } 

# Apply to Existential Solving 

* <=> true 
* <=> false 
0 <= * 
* < 0 
* <=> (0 <= *) 

divIf x = if (isNat x) then 1/(1+x) else 1/(-x)

#SubTyping 
x:?, {b:Bool|  b}     |= {v:Int v = 1+x} <: {v:Int | 0 < v } 
x:?, {b:Bool| not b} |= {v:Int v = -x}  <: {v:Int | 0 < v } 

# Liquid Typing Algorithm 
x:? |= v <=> 0 <= x  <: k v  

# Gradial Liquid Typing: Inference
   
  _Solving Existential_
  Answer: Exhaustive Search
   Is it more work?

Applications
-------------

divIf x = 
  | isPos x   = 1/x       0 < x
  | isNat x   = 1/(1+x)   0 <= x 
  | otherwise = 1/(-x)    x < 0




# 
index 8 [1..42]   -- i == 8 
index j (tail ys) -- 0 < j 
index i xs        -- 0 <= i 


-- 0 < i <= length xs 
index (x:xs) 1 = x
index (x:xs) i = index xs (i-1)
index xs     i = error "Out of bounds!" 

In theory 
How to solve exitential?
With Exhaustive Reasch 

Inference & Implementation 




