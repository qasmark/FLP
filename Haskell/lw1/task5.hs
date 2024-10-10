-- 5. Список пирамидальных чисел Ферма. Количество чисел в списке = 50 
-- Функция для вычисления пирамидальных чисел
pyramidal :: (Int -> Int) -> Int -> [Int]
pyramidal formula k = take k [formula n | n <- [1..]]

-- Формула для четырехугольной пирамиды
fourPyramidal :: Int -> Int
fourPyramidal n = n * (n + 1) * (2 * n + 1) `div` 6

-- Формула для треугольной пирамиды
triangularPyramidal :: Int -> Int
triangularPyramidal n =  n * (n + 1) * (n + 2) `div` 6

main :: IO ()
main = do
    let count = 50
    putStrLn "Four-angle pyramid:"
    print (pyramidal fourPyramidal count)
    putStrLn "Triangle pyramid:"
    print (pyramidal triangularPyramidal count)
