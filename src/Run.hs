module Run where

import Styles
import Text.Blaze.Html.Renderer.Text (renderHtml)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Web.Scotty

run :: IO ()
run =
  scotty 3000 $
    get "/" $
      html $
        renderHtml $
          H.html $ do
            H.head $ do
              H.title "Крестики, нолики"
              H.style styles
            H.body $ do
              H.div H.! A.class_ "container" $ do
                H.p "Ход игрока: X"
                H.div H.! A.class_ "game-board" $ do
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ "x"
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ "o"
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ ""
                  H.div H.! A.class_ "game-board_cell" $ ""
