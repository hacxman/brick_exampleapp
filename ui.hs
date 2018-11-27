module Main where

import Control.Monad
import Brick
import qualified Graphics.Vty as V

data TheProgram = TheProgram { _pizda :: String } deriving (Eq, Show)

data Tick = Tick

type Unit = ()
app :: App TheProgram Tick ()
app = App { appDraw = drawUI
          , appChooseCursor = neverShowCursor
          , appHandleEvent = handleEvent
          , appStartEvent = return
          , appAttrMap = const $ attrMap V.defAttr []
          }

initProgram = do
    pure $ TheProgram { _pizda = "" }

handleEvent self (AppEvent                Tick)    = continue self
handleEvent self (VtyEvent (V.EvKey V.KEsc []))    = halt self
handleEvent self _ = continue self

drawUI :: TheProgram -> [Widget ()]
drawUI p = [str "Hello, world!"]

main :: IO ()
main = do
  p <- initProgram
  void $ customMain (V.mkVty V.defaultConfig) Nothing app p
