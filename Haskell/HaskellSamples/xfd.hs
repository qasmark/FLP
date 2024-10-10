import Data.Char

test ch = isDigit ch

main :: IO ()
main = print $ test '5'