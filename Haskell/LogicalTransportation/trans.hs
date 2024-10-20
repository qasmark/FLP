data Side = L | R deriving (Eq, Show, Read)

          -- (фермер, волк, коза, капуста)
type State = (Side, Side, Side, Side)

isValidState :: State -> Bool
isValidState (farmer, wolf, goat, cabbage) =
    (farmer == goat || (goat /= wolf && goat /= cabbage))

getPossibleMoves :: State -> [State]
getPossibleMoves (farmer, wolf, goat, cabbage) =
    filter isValidState
        [ (move farmer, wolf, goat, cabbage) -- Фермер перемещается один
        , (move farmer, move wolf, goat, cabbage) -- Фермер и волк
        , (move farmer, wolf, move goat, cabbage) -- Фермер и коза
        , (move farmer, wolf, goat, move cabbage) -- Фермер и капуста
        ]
    where
        move L = R
        move R = L

-- реализовал DFS
solveByDFS :: [State] -> [State] -> State -> Maybe [State]
solveByDFS visited [] _ = Nothing
solveByDFS visited (current:rest) goalState
    | current == goalState = Just (reverse (current:visited)) -- достигнуто конечное состояние
    | otherwise = solveByDFS (current:visited) (nextStates ++ rest) goalState
    where
        nextStates = filter (`notElem` visited) (getPossibleMoves current)

-- сделал простую функцию для реализации псевдографики в терминале
visualizeState :: State -> String
visualizeState (farmer, wolf, goat, cabbage) =
    let leftBank = [if farmer == L then "F" else " ", if wolf == L then "W" else " ", if goat == L then "G" else " ", if cabbage == L then "C" else " "]
        rightBank = [if farmer == R then "F" else " ", if wolf == R then "W" else " ", if goat == R then "G" else " ", if cabbage == R then "C" else " "]
    in unwords leftBank ++ " |~~~~| " ++ unwords rightBank

parseState :: String -> State
parseState input = case words input of
    ["L", "L", "L", "L"] -> (L, L, L, L)
    ["R", "R", "R", "R"] -> (R, R, R, R)
    [f, w, g, c]         -> (read f, read w, read g, read c)
    _                    -> error "Invalid data format."

main :: IO ()
main = do
    putStrLn "Enter start state (for example, 'L L L L'):"
    startInput <- getLine
    putStrLn "Enter finite state (for example, 'R R R R'):"
    goalInput <- getLine
    let startState = parseState startInput
    let goalState = parseState goalInput
    let solution = solveByDFS [] [startState] goalState
    case solution of
        Nothing -> putStrLn "No solution."
        Just steps -> mapM_ (putStrLn . visualizeState) steps
