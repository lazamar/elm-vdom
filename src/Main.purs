module Main where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)

-- Define DOM effect type
foreign import data DOM :: Effect

foreign import toDOM :: forall e. String -> Eff (dom :: DOM | e) Int

main :: forall e. Eff (console :: CONSOLE , dom :: DOM | e) Unit
main = do
	a <- toDOM "SUCKER!!!"
  	logShow a
  	log $ "Hello sucker!" <> show a
