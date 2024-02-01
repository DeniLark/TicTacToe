{-# LANGUAGE TupleSections #-}

module TicTacToe.GameBoard where

import Data.Ix (Ix (range))
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (isNothing)
import TicTacToe.Player (Player)

type GameBoard = Map (Int, Int) (Maybe Player)

emptyGameBoard :: GameBoard
emptyGameBoard =
  M.fromList $ map (,Nothing) (range ((1, 1), (3, 3)))

isFullGameBoard :: GameBoard -> Bool
isFullGameBoard = not . any isNothing . M.elems