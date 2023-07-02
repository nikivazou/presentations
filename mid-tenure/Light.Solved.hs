module Light where 

-- 1. Let's test the build-in (!!) indexing 

{-@ test :: [{v:Int | v /= 0 }] -> Int -> Maybe Int @-}
test :: [Int] -> Int -> Maybe Int
test xs i = 
    if 0 <= i && i < length xs
        then Just (42 `div` (xs !! i))
        else Nothing






-- 2. Try other build-in primitives, e.g., division! 
-- 3. Remove runtime check 
