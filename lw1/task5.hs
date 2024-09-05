-- 5. Список пирамидальных чисел Ферма. Количество чисел в списке = 50
-- Взял как число точек в четырехугольных пирамидах 
pyramidalNumbers :: Int -> [Int]
pyramidalNumbers k = take k [n * (n + 1) * (2 * n + 1) `div` 6 | n <- [1..]]

main :: IO ()
main = do
    let count = 50
    print (pyramidalNumbers count)
    print (length (pyramidalNumbers count))