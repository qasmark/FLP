module LW4 (myDeleteMap, myDeleteSet, myDrop, myToLower, myMaybe, test) where

-- myDeleteMap - Удаляет элемент из Map по ключу
data Map k a = EmptyMap | Node k a (Map k a) (Map k a)
  deriving (Show, Eq)

myDeleteMap :: (Ord k) => k -> Map k a -> Map k a
myDeleteMap _ EmptyMap = EmptyMap
myDeleteMap key (Node k v left right)
  | key < k   = Node k v (myDeleteMap key left) right
  | key > k   = Node k v left (myDeleteMap key right)
  | otherwise = case (left, right) of
      (EmptyMap, _) -> right
      (_, EmptyMap) -> left
      (_, _) -> let (minKey, minVal) = findMin right
                in Node minKey minVal left (myDeleteMap minKey right)
  where
    findMin (Node k v EmptyMap _) = (k, v)
    findMin (Node _ _ left _)     = findMin left

-- myDeleteSet - Удаляет элемент из множества
data Set a = EmptySet | Element a (Set a) (Set a)
  deriving (Show, Eq)

myDeleteSet :: (Ord a) => a -> Set a -> Set a
myDeleteSet _ EmptySet = EmptySet
myDeleteSet x (Element e left right)
  | x < e     = Element e (myDeleteSet x left) right
  | x > e     = Element e left (myDeleteSet x right)
  | otherwise = case (left, right) of
      (EmptySet, _) -> right  -- No left child, promote right
      (_, EmptySet) -> left   -- No right child, promote left
      (_, _) -> let minElem = findMin right
                    in Element minElem left (myDeleteSet minElem right)
  where
    -- Find the minimum element in the right subtree
    findMin (Element e EmptySet _) = e
    findMin (Element _ left _)     = findMin left

-- myDrop - Удаляет первые n элементов из спикса
myDrop :: Int -> [a] -> [a]
myDrop n xs
  | n <= 0    = xs
  | otherwise = case xs of
                  []   -> []
                  _:xs' -> myDrop (n-1) xs'

-- mytoLower - Преобразует символ в нижний регистр
myToLower :: Char -> Char
myToLower c
  | c >= 'A' && c <= 'Z' = toEnum (fromEnum c + 32)
  | otherwise            = c

-- myMaybe - Применяет функцию к значению Maybe, если оно есть, иначе возвращает значение по умолчанию
myMaybe :: b -> (a -> b) -> Maybe a -> b
myMaybe defaultVal f maybeVal = case maybeVal of
  Nothing -> defaultVal
  Just x  -> f x

test :: (Eq a, Show a) => a -> a -> IO ()
test expected actual
  | expected == actual = putStrLn $ "Test passed: " ++ show actual
  | otherwise          = putStrLn $ "Test failed: expected " ++ show expected ++ ", but got " ++ show actual

main :: IO ()
main = do
  let m = Node 1 "a" (Node 0 "z" EmptyMap EmptyMap) (Node 2 "b" EmptyMap EmptyMap)
  test (Node 1 "a" (Node 0 "z" EmptyMap EmptyMap) EmptyMap) (myDeleteMap 2 m)
  test (Node 2 "b" (Node 0 "z" EmptyMap EmptyMap) EmptyMap) (myDeleteMap 1 m)

  let s = Element 2 (Element 1 EmptySet EmptySet) (Element 3 EmptySet EmptySet)
  test (Element 2 (Element 1 EmptySet EmptySet) EmptySet) (myDeleteSet 3 s)
  test (Element 3 (Element 1 EmptySet EmptySet) EmptySet) (myDeleteSet 2 s)

  test [3, 4] (myDrop 2 [1, 2, 3, 4])
  test [] (myDrop 5 [1, 2, 3])
  test [1, 2, 3] (myDrop 0 [1, 2, 3])

  test 'a' (myToLower 'A')
  test 'b' (myToLower 'b')
  test '1' (myToLower '1')
  test '\n' (myToLower '\n' )  

  test 6 (myMaybe 0 (+1) (Just 5))
  test 0 (myMaybe 0 (+1) Nothing)
