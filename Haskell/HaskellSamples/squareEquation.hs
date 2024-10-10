module Demo where
roots :: Double -> Double -> Double 
    -> (Double, Double)
roots a b c = 
    (
        (-b - sqrt(b ^ 2 - 4 * c * a) / (2 * a ))
    ,
        (-b + sqrt(b ^ 2 - 4 * c * a) / (2 * a ))
    )

-- let .. in  (локальные связывания)
roots' a b c =
	let d = sqrt(b^2 - 4 * a * c) in
	((-b - d ) / (2 * a), (-b + d) / (2 * a))

-- несколько связываний
roots'' a b c = 
	let {d = sqrt (b^2 - 4 * a * c); x1 = (-b - d ) / (2 * a); x2 = (-b + d ) / (2 * a)}
	in (x1, x2)

-- с отступами
roots''' a b c = 
	let
		x1 = (- b - d) / aTwice
		x2 = (- b + d) / aTwice
		d = sqrt $ b ^ 2 - 4 * a * c
		aTwice = 2 * a 
	in (x1, x2)



-- локальные отступы для работы с рекурсией и вспомогательных функций
-- засоряет глобальное пространство имен
-- лучше определить локальное
factorial5 :: Integer -> Integer
factorial5 n | n >= 0 = helper 1 n 
             | otherwise = error "args must be >= 0"

helper :: Integer -> Integer -> Integer 
helper acc 0 = acc -- терминирующее условие
helper acc n = helper (acc * n) (n - 1) -- параметры изменяются


-- исправления
factorial6 n
	| n >= 0 = let
		helper acc 0 = acc
		helper acc n = helper (acc * n) (n - 1)
		-- механизм сопоставления с образцом
		-- отступы одинаковые во всех равенствах, больше нуля
	 in helper 1 n
	| otherwise = error "arg must be >= 0"

-- локальное связывание образцом
rootsDiff a b c = let
  (x1, x2) = roots a b c 
  in x2 - x1