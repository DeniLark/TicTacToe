module TicTacToe.Player where

import Text.Blaze.Html5 (ToMarkup (toMarkup))

data Player = X | O deriving (Eq)

instance ToMarkup Player where
  toMarkup X = "X"
  toMarkup O = "O"

swapPlayer :: Player -> Player
swapPlayer X = O
swapPlayer O = X