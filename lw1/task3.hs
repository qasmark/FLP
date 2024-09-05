-- 3. Список нечётных натуральных чисел. Количество чисел в списке = 20. (не менее 3 разных способа)
-- Используя список генераторов
oddNumbersGen :: Int -> [Int]
oddNumbersGen n = take n [x | x <- [1..], odd x]

-- Используя рекурсию
oddNumbersRec :: Int -> [Int]
oddNumbersRec n = take n (filter odd [1..])

-- Используя map
oddNumbersMap :: Int -> [Int]
oddNumbersMap n = take n (map (\x -> 2 * x + 1) [0..])

main :: IO ()
main = do
    let count = 20 
    print (oddNumbersGen count)
    print (length (oddNumbersGen count))
    
    print (oddNumbersRec count)
    print (length (oddNumbersRec count))
    
    print (oddNumbersMap count)
    print (length (oddNumbersMap count))
