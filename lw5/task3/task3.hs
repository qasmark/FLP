import System.IO
import System.Environment
import Control.Monad
import Data.List (isInfixOf, delete)
import Data.Char (toLower, isAsciiLower, isAsciiUpper)

viewFile :: FilePath -> IO ()
viewFile path = do
    contents <- readFile path
    let linesOfFile = lines contents
    viewLines linesOfFile 0
  where
    viewLines :: [String] -> Int -> IO ()
    viewLines [] _ = return ()
    viewLines ls n = do
        let (chunk, rest) = splitAt 20 ls
        mapM_ putStrLn chunk
        let shown = n + length chunk
        let remaining = length rest
        let startLine = n + 1
        let endLine = shown
        putStrLn $ "Shown lines: " ++ show startLine ++ "-" ++ show endLine ++ ", Lines left: " ++ show remaining
        when (not $ null rest) $ do
            putStrLn "Press Enter to continue or type 'q' to quit."
            command <- getLine
            unless (command == "q") $ viewLines rest shown

appendToFile :: FilePath -> String -> IO ()
appendToFile path newContent = withFile path AppendMode $ \handle -> do
    contents <- hGetContents handle
    let needsNewLine = not (null contents) && last contents /= '\n'
    let contentToAppend = if needsNewLine then "\n" ++ newContent else newContent
    hPutStr handle contentToAppend

deleteLine :: FilePath -> Int -> IO ()
deleteLine path lineNumber = do
    contents <- readFile path
    let linesOfFile = lines contents
    if lineNumber < 1 || lineNumber > length linesOfFile
        then putStrLn "Error: unknown number of line."
        else do
            let newContents = unlines $ delete (linesOfFile !! (lineNumber - 1)) linesOfFile
            writeFile path newContents

longLineFilter :: String -> Bool
longLineFilter line = length line > 15

isOnlyLatinLine :: String -> Bool
isOnlyLatinLine = all (\c -> isAsciiLower c || isAsciiUpper c || c == ' ')

copyWithFilters :: FilePath -> FilePath -> (String -> Bool) -> (String -> Bool) -> IO ()
copyWithFilters sourcePath destPath filter1 filter2 = do
    contents <- readFile sourcePath
    let filteredContents = filter (\line -> filter1 line && filter2 line) (lines contents) 
    writeFile destPath (unlines filteredContents)

main :: IO ()
main = do
  args <- getArgs
  case args of 
    ("view" : filePath : _) -> viewFile filePath
    ("append" : filePath : newContent : _) -> appendToFile filePath newContent
    ("delete" : filePath : lineNumberStr : _) -> deleteLine filePath (read lineNumberStr)
    ("copy" : sourcePath : destPath : filters) -> do
      let (filter1, filter2) = case filters of
            ["latin", "long"] -> (isOnlyLatinLine, longLineFilter) 
            ["long", "latin"] -> (longLineFilter, isOnlyLatinLine)
      copyWithFilters sourcePath destPath filter1 filter2
    ("exit" : _) -> putStrLn "Выход из программы."
    _ -> putStrLn "Unknown command. Usage file.exe:\n    view <source File>\n    append <source file> <string to add>\n    delete <source file> <string number>\n    copy <source file> <target file> [latin|long] [long|latin]"