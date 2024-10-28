import Data.List (nub)
import qualified Data.Set as Set
import Data.Maybe (isJust, fromMaybe)

data Side = L | R deriving (Eq, Show, Read, Ord)

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

solveByBFS :: [State] -> State -> Maybe [State]
solveByBFS visited goalState = case visited of
    [] -> Nothing
    (startState:_) -> bfs [[startState]] Set.empty
  where
    bfs [] _ = Nothing
    bfs (path:paths) seen = case path of
        [] -> Nothing
        (current:_) 
            | current == goalState -> Just (reverse path)
            | otherwise -> bfs (paths ++ newPaths) (Set.union seen (Set.fromList nextStates))
          where
            nextStates = filter (`Set.notMember` seen) (getPossibleMoves current)
            newPaths = [nextState:path | nextState <- nextStates]

visualizeState :: State -> String
visualizeState (farmer, wolf, goat, cabbage) =
    let leftBank = [if farmer == L then "F" else " ", if wolf == L then "W" else " ", if goat == L then "G" else " ", if cabbage == L then "C" else " "]
        rightBank = [if farmer == R then "F" else " ", if wolf == R then "W" else " ", if goat == R then "G" else " ", if cabbage == R then "C" else " "]
    in unwords leftBank ++ " |~~~~| " ++ unwords rightBank

parseState :: String -> State
parseState input = case words input of
    [f, w, g, c]         -> (read f, read w, read g, read c)
    _                    -> error "Invalid data format. Usage:\nL L L L\nR R R R"

main :: IO ()
main = do
    putStrLn "Use this order to complete pos: 'Farmer Wolf Goat Cabbage'"
    putStrLn "Enter start state (for example, 'L L L L'):"
    startInput <- getLine
    putStrLn "Enter finite state (for example, 'R R R R'):"
    goalInput <- getLine
    let startState = parseState startInput
    let goalState = parseState goalInput
    let solution = solveByBFS [startState] goalState
    case solution of
        Nothing -> putStrLn "No solution."
        Just steps -> do
            mapM_ (putStrLn . visualizeState) steps
            putStrLn $ "Total moves: " ++ show (length steps - 1)
