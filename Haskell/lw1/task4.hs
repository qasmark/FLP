-- 4. Список треугольных чисел Ферма. Количество чисел в списке = 50.
triangleNumbers :: Int -> [Int]
triangleNumbers n = take n [k * (k + 1) `div` 2 | k <- [1..]]

main :: IO ()
main = do
    let count = 50
    print (triangleNumbers count)
    print (length (triangleNumbers count))