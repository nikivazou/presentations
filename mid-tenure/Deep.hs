{-@ LIQUID "--reflection" @-}
module Deep where 

import Prelude hiding ((++), reverse)
import Language.Haskell.Liquid.ProofCombinators
{-@ infixr ++ @-}



{-@ rightId :: xs:[a] -> { xs ++ [] = xs } @-}
rightId :: [a] -> () 
rightId []    = ()
rightId (x:xs) = rightId xs 


{-@ LIQUID "--ple" @-}








{-@ assoc :: xs:[a] -> ys:[a] -> zs:[a] 
          -> { xs ++ (ys ++ zs) == (xs ++ ys) ++ zs } @-}
assoc :: [a] -> [a] -> [a] -> ()
assoc [] ys zs = ()
assoc (x:xs) ys zs = assoc xs ys zs








{-@ rewriteWith distributivity [assoc, rightId] @-}


distributivity :: [a] -> [a] -> () 
{-@ distributivity :: xs:[a] -> ys:[a] 
                   -> { reverse (xs ++ ys) == reverse ys ++ reverse xs }  @-}
distributivity [] _ = ()
distributivity (x:xs) ys = distributivity xs ys



















---------------------------
-- Reflected Definitions --
---------------------------

{-@ reflect ++ @-}
(++) :: [a] -> [a] -> [a]
[]     ++ ys = ys 
(x:xs) ++ ys = x:(xs++ys)

{-@ reflect reverse @-}
reverse :: [a] -> [a]
reverse [] = [] 
reverse (x:xs) = reverse xs ++ [x]
