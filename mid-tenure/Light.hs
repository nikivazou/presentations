module Light where 

-- 1. Let's test the build-in (!!) indexing 

{-@ test :: xs:[{v:Int | 0 /= v }] -> i:{Int | 0 <= i && i < len xs } ->  Int @-}
test :: [Int] -> Int ->  Int
test xs i = 42 `div` xs !! i

-- 2. Try other build-in primitives, e.g., division! 
-- 3. Remove runtime check 
