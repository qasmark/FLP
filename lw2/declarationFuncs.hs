module DeclarationFunctions where 

-- 1. oddEven
oddEven :: [a] -> [a]
-- Функция перестановки местами соседних элементов списка
-- На вход поступает список любого типа, принимает только 1 аргумент, возвращает список того же типа

-- oddEven [2,5,7,9,1,8] вернет [5,2,9,7,8,1]
-- oddEven [1,2,3,4] вернет [2,1,4,3]
-- oddEven [1] вернет [1]
-- oddEven [1,2,3] вернет [2,1,3]
-- oddEven ([] :: [Int]) вернет []
oddEven (x:y:xs) = y : x : oddEven xs
oddEven xs = xs

testOddEven :: IO ()
testOddEven = do
    print $ oddEven [2,5,7,9,1,8] -- Ожидается: [5,2,9,7,8,1]
    print $ oddEven [1,2,3,4]     -- Ожидается: [2,1,4,3]
    print $ oddEven [1,2,3]
    print $ oddEven [1]           -- Ожидается: [1]
    print $ oddEven ([] :: [Int]) -- Ожидается: []

-- 2. insert
insert :: [a] -> a -> Int -> [a]
-- Функция включения в список заданного элемента на определенную позицию n
-- На вход поступает список, элемент любого типа и индекс позиции n
-- Возвращает список с вставленным элементом на позицию n

-- insert [1,2,3,4] 10 2 вернет [1,2,10,3,4]
-- insert [1,2,3,4] 5 0  вернет [5,1,2,3,4]
-- insert [1,2,3,4] 6 4  вернет [1,2,3,4,6]
insert xs a n = take n xs ++ [a] ++ drop n xs

testInsert :: IO ()
testInsert = do
    print $ insert [1,2,3,4] 10 2 
    print $ insert [1,2,3,4] 5 0  
    print $ insert [1,2,3,4] 6 4  

-- 3. listSumm
listSumm :: [Int] -> [Int] -> [Int]
-- Функция сложения элементов двух списков
-- На вход поступают два списка целых чисел, функция складывает элементы по индексам
-- Если длины списков разные, то элементы из более длинного списка добавляются в конец результата

-- listSumm([1,2,3], [4,5,6]) вернет [5,7,9]
-- listSumm [1,2] [4,5,6] вернет [5,7,6]
-- listSumm [1,2,3] [4,5] вернет [5,7,3]
listSumm [] [] = []
listSumm xs [] = xs
listSumm [] ys = ys
listSumm (x:xs) (y:ys) = (x + y) : listSumm xs ys

testListSumm :: IO ()
testListSumm = do
    print $ listSumm [1,2,3] [4,5,6] -- Ожидается: [5,7,9]
    print $ listSumm [1,2] [4,5,6]   -- Ожидается: [5,7,6]
    print $ listSumm [1,2,3] [4,5]   -- Ожидается: [5,7,3]

-- 4. position
position :: Eq a => [a] -> a -> Maybe Int
-- Функция нахождения позиции первого вхождения элемента в список
-- На вход поступает список любого типа и элемент для поиска
-- Возвращает Maybe Int с индексом первого вхождения или Nothing, если элемент не найден

-- position [1,2,3,4,2] 2 вернет Just 1
-- если элемент не найден, возвращается Nothing
-- position [1,2,3,4] 5 вернет Nothing
-- position "haskell" 'l' вернет Just 4
position xs a = positionHelper xs a 0
  where
    positionHelper [] _ _ = Nothing
    positionHelper (x:xs) a i
      | x == a    = Just i
      | otherwise = positionHelper xs a (i + 1)

testPosition :: IO ()
testPosition = do
    print $ position [1,2,3,4,2] 2
    print $ position [1,2,3,4,5] 10
    print $ position [1,2,3,4] 5 
    print $ position "haskell" 'l'


-- 5. sumF1
sumF1 :: Int -> Int
-- Функция вычисления суммы F(n) = ∑i=1n (i)
-- На вход поступает целое число n, функция возвращает сумму всех чисел от 1 до n включительно

-- sumF1(5) вернет 15 (1 + 2 + 3 + 4 + 5)
-- sumF1 10 вернет 55
-- sumF1 0 вернет 0
sumF1 n = sum [1..n]

testSumF1 :: IO ()
testSumF1 = do
    print $ sumF1 5 
    print $ sumF1 10
    print $ sumF1 0 

-- 6. sumF2
sumF2 :: Int -> Int
-- Функция вычисления суммы F(n) = ∑i=1n (n−i)
-- На вход поступает целое число n, функция возвращает сумму разностей между n и каждым i от 1 до n

-- sumF2(5) вернет 10 (5-1 + 5-2 + 5-3 + 5-4 + 5-5)
-- sumF2 5 вернет 10
-- sumF2 10 вернет 45
-- sumF2 0 вернет 0
sumF2 n = sum [n - i | i <- [1..n]]

testSumF2 :: IO ()
testSumF2 = do
    print $ sumF2 5  -- Ожидается: 10
    print $ sumF2 10 -- Ожидается: 45
    print $ sumF2 0  -- Ожидается: 0

main :: IO ()
main = do
    testOddEven
    print $ "--------"
    testInsert
    print $ "--------"
    testListSumm
    print $ "--------"
    testPosition
    print $ "--------"
    testSumF1
    print $ "--------"
    testSumF2
