module Lw3 where

-- 1. listnums. Она берет численный аргумент n  и возвращает список всех чисел от n до 1, включительно. 
listnums :: Int -> Maybe [Int]
listnums n
  | n < 0 = Nothing
  | otherwise = Just (go n)
  where
    go 0 = []
    go x = x : go (x - 1)

-- 2. secondlastlist. Эта функция берет список  списков и возвращает последние элементы каждого, объединенные  в список.  
secondlastlist :: [[a]] -> Maybe [a]
secondlastlist [] = Nothing 
secondlastlist xss
  | any null xss = Nothing 
  | otherwise = Just (map last xss)

-- 3. myunion, которая находит объединение двух  списков. 
--Объединением двух списков будет список содержащий элементы,  которые есть по крайней мере в одном из списков.  
myunion :: Eq a => [a] -> [a] -> [a]
myunion [] ys = ys
myunion (x:xs) ys
    | x `elem` ys = myunion xs ys
    | otherwise = x : myunion xs ys

-- 4.  mysubst. Получив два списка, она возвращает их разность. 
-- Разность двух списков называется список, состоящий из элементов  первого списка, которые не принадлежат второму списку.  
mysubst :: Eq a => [a] -> [a] -> [a]
mysubst xs ys = xs >>= \x -> if x `elem` ys then [] else [x]


-- 5. nposlist, берущую список списков и возвращающую список из N -х элементов подсписков с помощью функций map и (!!)  
nposlist :: Int -> [[a]] -> Maybe [a]
nposlist n xss
  | any (\xs -> length xs <= n) xss = Nothing
  | otherwise = Just (map (!! n) xss)

main :: IO ()
main = do
  print $ listnums 5           
  print $ listnums 0            
  print $ listnums $ -1

  print $ secondlastlist [[1,2], [3,4], [5,6]]  
  print $ secondlastlist [[1,2], [], [5,6]]    
  print $ secondlastlist [[], [], ['a']]

  print $ myunion [1, 2, 3] [3, 4, 5]   
  print $ myunion [1,2,3] []

  print $ mysubst [1, 2, 3, 4] [2, 4]
  print $ mysubst [1, 2, 3, 4, 5, 10] [3, 4, 5]

  print $ nposlist 1 [[1, 2], [3, 4], [5, 6]]      
  print $ nposlist 3 [[1, 2], [3, 4], [5, 6]]
