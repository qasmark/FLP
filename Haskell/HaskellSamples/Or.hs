sf xs = tail xs
sf [] = []
main :: IO()

main = do
    print $ sf [1,2]
    print $ sf [1]
    print $ tail [1,2]
    print $ tail [1]