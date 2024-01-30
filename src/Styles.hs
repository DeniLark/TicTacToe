module Styles (styles) where

import Text.Blaze.Html5 (Html)

styles :: Html
styles =
  mconcat
    [ ".container { max-width: 300px; width: 100%; margin: 0 auto; }",
      ".game-board { display: flex; flex-wrap: wrap; }",
      ".game-board_cell { box-sizing: border-box; width: 33%; border: 1px solid black; position: relative; display: flex; justify-content: center; align-items: center; text-transform: uppercase; }",
      ".game-board_cell::before { content: \"\"; display: block; padding-top: 100%;}"
    ]