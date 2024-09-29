import System.Environment (getArgs)

replacePunctuation :: Char -> String -> String
replacePunctuation _ [] = []
replacePunctuation newChar (x:xs)
  | x == '.' || x == ',' || x == ';' = newChar : replacePunctuation newChar xs 
  | otherwise = x : replacePunctuation newChar xs

processFile :: FilePath -> FilePath -> Char -> IO ()
processFile sourceFile targetFile replaceChar = do
  content <- readFile sourceFile
  let newContent = replacePunctuation replaceChar content 
  writeFile targetFile newContent

main :: IO ()
main = do
  args <- getArgs
  case args of
    [sourceFile, targetFile, replaceCharStr] -> do
      let replaceChar = head replaceCharStr
      processFile sourceFile targetFile replaceChar
    _ -> putStrLn "Usage: program <sourceFile> <targetFile> <replaceChar>" 