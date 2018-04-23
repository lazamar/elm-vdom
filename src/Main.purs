module Main where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Elm.VirtualDom (text, DOM)

main :: forall e. Eff (console :: CONSOLE , dom :: DOM | e) Unit
main = do
	a <- text "SUCKER!!!"
  	logShow a
  	log $ "Hello sucker!" <> show a
