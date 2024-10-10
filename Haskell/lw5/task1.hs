import System.Environment (getArgs)
import Text.Read (readMaybe)

generateList :: (Num a, Enum a) => a -> Int -> a -> [a]
generateList start count step = take count [start, start + step ..]

parseArgs :: [String] -> Maybe (Double, Int, Double)
parseArgs [startStr, countStr, stepStr] = do
  start <- readMaybe startStr
  count <- readMaybe countStr
  step <- readMaybe stepStr
  return (start, count, step)
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs	
  case parseArgs args of
    Just (start, count, step) -> do
      let result = generateList start count step
      putStrLn $ show result
    Nothing -> putStrLn "Error: wrong arguments \nUsage: file.exe <number> <number> <number>" 