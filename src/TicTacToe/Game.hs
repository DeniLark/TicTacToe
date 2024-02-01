module TicTacToe.Game
  ( GameState (End, Proccess),
    initialGameState,
    stepPlayer,
    module TicTacToe.Player,
    module TicTacToe.GameBoard,
  )
where

import Control.Monad (join)
import qualified Data.Map as M
import TicTacToe.GameBoard
  ( GameBoard,
    emptyGameBoard,
    isFullGameBoard,
  )
import TicTacToe.Player (Player (X), swapPlayer)

data GameState
  = Proccess Player GameBoard
  | End (Maybe Player) GameBoard

initialGameState :: GameState
initialGameState = Proccess X emptyGameBoard

stepPlayer :: (Int, Int) -> GameState -> GameState
stepPlayer _ gs@(End _ _) = gs
stepPlayer xy (Proccess p gb) = newGameState
  where
    newGameBoard = M.insert xy (pure p) gb
    newGameState =
      if isFullGameBoard newGameBoard
        then End (getWinner newGameBoard) newGameBoard
        else case getWinner newGameBoard of
          Nothing -> Proccess (swapPlayer p) newGameBoard
          Just p' -> End (Just p') newGameBoard

getWinner :: GameBoard -> Maybe Player
getWinner gb =
  foldr foldFunc Nothing $
    concat [diagonals, verticals, horizontals]
  where
    foldFunc :: [(Int, Int)] -> Maybe Player -> Maybe Player
    foldFunc _ p@(Just _) = p
    foldFunc xy _ = checkOne xy

    diagonals, verticals, horizontals :: [[(Int, Int)]]
    diagonals = [[(1, 1), (2, 2), (3, 3)], [(1, 3), (2, 2), (3, 1)]]
    verticals =
      [ [(1, 1), (2, 1), (3, 1)],
        [(1, 2), (2, 2), (3, 2)],
        [(1, 3), (2, 3), (3, 3)]
      ]
    horizontals =
      [ [(1, 1), (1, 2), (1, 3)],
        [(2, 1), (2, 2), (2, 3)],
        [(3, 1), (3, 2), (3, 3)]
      ]
    checkOne :: [(Int, Int)] -> Maybe Player
    checkOne = helper . map loockupGB
      where
        helper :: [Maybe Player] -> Maybe Player
        helper [] = Nothing
        helper (p : ps)
          | all (== p) ps = p
          | otherwise = Nothing

    loockupGB :: (Int, Int) -> Maybe Player
    loockupGB = join . (`M.lookup` gb)
