module HTML where

import qualified Data.Map as M
import Styles
import Text.Blaze.Html (Html)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import TicTacToe.Game

htmlMainPage :: Player -> GameBoard -> Html
htmlMainPage player gameBoard = H.html $ do
  H.head $ do
    H.title "Крестики, нолики"
    H.style styles
  H.body $ do
    H.div H.! A.class_ "container" $ do
      H.p $ "Ход игрока: " <> H.toHtml player
      htmlGameBoard gameBoard
      H.a
        H.! A.class_ "start-again"
        H.! A.href "/start-again"
        $ "Начать заново"

htmlEndPage :: Maybe Player -> GameBoard -> Html
htmlEndPage player gameBoard = H.html $ do
  H.head $ do
    H.title "Крестики, нолики"
    H.style styles
  H.body $ do
    H.div H.! A.class_ "container" $ do
      case player of
        Nothing -> H.p "Ничья"
        Just p -> H.p $ "Победитель: " <> H.toHtml p
      htmlGameBoard gameBoard
      H.a
        H.! A.class_ "start-again"
        H.! A.href "/start-again"
        $ "Начать заново"

htmlGameBoard :: GameBoard -> Html
htmlGameBoard gameBoard =
  H.div H.! A.class_ "game-board" $
    M.foldrWithKey (\xy -> (<>) . htmlGameBoardCell xy) "" gameBoard

htmlGameBoardCell :: (Int, Int) -> Maybe Player -> Html
htmlGameBoardCell (x, y) Nothing =
  let link = "/step?x=" <> H.toValue x <> "&y=" <> H.toValue y
   in H.div H.! A.class_ "game-board_cell" $
        H.a H.! A.href link H.! A.class_ "game-board_link" $
          ""
htmlGameBoardCell _ (Just p) =
  H.div H.! A.class_ "game-board_cell" $ H.toMarkup p
