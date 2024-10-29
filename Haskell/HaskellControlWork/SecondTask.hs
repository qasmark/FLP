module SecondTask where
import Data.List (groupBy, sortBy)
import Data.Ord (comparing)

getPythagoreanTriplets :: Int -> [[Int]]
getPythagoreanTriplets x = 
    let triplets = [(a, b, c) | a <- [1..x], b <- [a+1..x], c <- [b+1..x], 
                                (a^2) + (b^2) == (c^2), 
                                even a, even b, even c]
        tripletSums = [(a, b, c, a + b + c) | (a, b, c) <- triplets]
        grouped = groupBy (\(_, _, _, sum1) (_, _, _, sum2) -> sum1 == sum2) 
                  (sortBy (comparing (\(_, _, _, sum) -> sum)) tripletSums)
        filteredGroups = filter (\group -> length group > 1) grouped
    in concatMap (map (\(a, b, c, sum) -> [a, b, c, sum])) filteredGroups

main :: IO ()
main = print $ getPythagoreanTriplets 200