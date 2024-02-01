{-# LANGUAGE ScopedTypeVariables #-}

module Run where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.IORef (modifyIORef, newIORef, readIORef, writeIORef)
import HTML (htmlEndPage, htmlMainPage)
import Text.Blaze.Html.Renderer.Text (renderHtml)
import TicTacToe.Game
  ( GameState (End, Proccess),
    initialGameState,
    stepPlayer,
  )
import Web.Scotty (get, html, queryParam, redirect, scotty)

run :: IO ()
run = do
  gameR <- newIORef initialGameState
  putStrLn "http://localhost:3000/"
  scotty 3000 $ do
    get "/" $ do
      game <- liftIO $ readIORef gameR
      html $
        renderHtml $
          case game of
            Proccess currentPlayer gameBoard ->
              htmlMainPage currentPlayer gameBoard
            End player gameBoard ->
              htmlEndPage player gameBoard

    get "/step" $ do
      x :: Int <- queryParam "x"
      y :: Int <- queryParam "y"
      liftIO $ modifyIORef gameR (stepPlayer (x, y))
      redirect "/"

    get "/start-again" $ do
      liftIO $ writeIORef gameR initialGameState
      redirect "/"
