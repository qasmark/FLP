-- GHC version 9.8.1
module ControlWorkHaskell where

import Data.List (sortOn, group, sortBy)
import Data.Char (isAlpha, toLower, isPunctuation, toLower)
import qualified Data.Map as Map
import System.IO (readFile, writeFile)

partitionN :: [a] -> Int -> [[a]]
partitionN xs n
  | null xs   = []                         
  | n <= 0    = []       
  | otherwise = chunksOfPartition xs basedLength delimiter
  where
    basedLength = length xs `div` n       
    delimiter = length xs `mod` n
    
chunksOfPartition [] _ _ = []
chunksOfPartition xs mainLen 0 = take mainLen xs : chunksOfPartition (drop mainLen xs) mainLen 0
chunksOfPartition xs mainLen rem = take (mainLen + 1) xs : chunksOfPartition (drop (mainLen + 1) xs) mainLen (rem - 1)

elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices x xs = [i | (i, y) <- zip [0..] xs, y == x]

powerLists :: Int -> Int -> [[Int]]
powerLists numElements maxBase = [take numElements [b^n | n <- [1..]] | b <- [1..maxBase]]



countWordsInFile :: FilePath -> FilePath -> IO ()
countWordsInFile inputFile outputFile = do
    content <- readFile inputFile
    let wordCounts = countWords content
    writeFile outputFile (formatOutput wordCounts)

-- слово не пробел и не пунктуация
countWords :: String -> [(String, Int)]
countWords text = 
    let wordsList = words $ map toLower $ filter (not . isPunctuation) text
        groupedWords = Map.toList $ Map.fromListWith (+) [(word, 1) | word <- wordsList]
    in sortByCount groupedWords

sortByCount :: [(String, Int)] -> [(String, Int)]
sortByCount = sortBy (\(_, count1) (_, count2) -> compare count2 count1)

formatOutput :: [(String, Int)] -> String
formatOutput = unlines . map (\(word, count) -> word ++ ": " ++ show count)

main :: IO ()
main = do
    putStrLn "partitionN:"
    print (partitionN [1,2,3,4,5,6,7] 3) 
    print (partitionN [1,2,3,4,5,6,7] 4)
    print (partitionN [1,2,3,4,5,6,7] 5)
    print (partitionN [1,2,3,4,5,6,7] 6)
    print (partitionN [1,2,3,4,5,6,7] 10)

    putStrLn "\nelemIndices:"
    print (elemIndices 3 [1,2,3,4,3,5]) 
    print (elemIndices 'a' "banana")
    print (elemIndices 1 [2,3,4])
    print (elemIndices 3 [1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,4,5,6,7,8,9,3,3,3,3,3])

    putStrLn "\npowerLists:"
    print (powerLists 2 4)
    print (powerLists 3 3)
    print (powerLists 0 0)
    print (powerLists 1 0)

    putStrLn "\nwordFrequency:"
    countWordsInFile "input.txt" "output.txt"