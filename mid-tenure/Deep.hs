{-@ LIQUID "--reflection" @-}
{-@ LIQUID "--ple" @-}
module Deep where 

import Prelude hiding ((++), reverse)
-- import Language.Haskell.Liquid.ProofCombinators
{-@ infixr ++ @-}

{-@ rightId :: xs:[a] -> { xs ++ [] = xs } @-}
rightId :: [a] -> () 
rightId [] = ()
rightId (_:xs) = rightId xs  









{-@ assoc :: xs:[a] -> ys:[a] -> zs:[a] 
          -> { xs ++ (ys ++ zs) == (xs ++ ys) ++ zs } @-}
assoc :: [a] -> [a] -> [a] -> ()
assoc [] _ _ = ()
assoc (_:xs) ys zs = assoc xs ys zs    









{-@ rewriteWith distributivity [assoc, rightId] @-}
distributivity :: [a] -> [a] -> () 
{-@ distributivity :: xs:[a] -> ys:[a] 
                   -> { v:() | reverse (xs ++ ys) == reverse ys ++ reverse xs }  @-}
distributivity [] _ = ()
distributivity (_:xs) ys = distributivity xs ys  









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
