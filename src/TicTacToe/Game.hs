{-# LANGUAGE TupleSections #-}

module TicTacToe.Game where

import Control.Monad (join)
import Data.Ix (Ix (range))
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (isNothing)
import Text.Blaze.Html5 (ToMarkup (toMarkup))

data Player = X | O deriving (Eq)

instance ToMarkup Player where
  toMarkup X = "X"
  toMarkup O = "O"

data GameState
  = Proccess Player GameBoard
  | End (Maybe Player) GameBoard

type GameBoard = Map (Int, Int) (Maybe Player)

initialGameState :: GameState
initialGameState = Proccess X emptyGameBoard

emptyGameBoard :: GameBoard
emptyGameBoard =
  M.fromList $ map (,Nothing) (range ((1, 1), (3, 3)))

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

swapPlayer :: Player -> Player
swapPlayer X = O
swapPlayer O = X

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

isFullGameBoard :: GameBoard -> Bool
isFullGameBoard = not . any isNothing . M.elems
