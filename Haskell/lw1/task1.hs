-- 1. Используя функции fst (возвращает первый элемент кортежа) и snd (возвращвет второй элемент кортежа из 2 элементов)
-- из стандартного модуля Prelude чтобы "достать" значение типа Char из кортежа (( 1, 'a'), "abc")
getCharFromTuple :: ((Int, Char), String) -> Char
getCharFromTuple = snd . fst

main :: IO ()
main = do
    print (getCharFromTuple ((1, 'a'), "abc"))