module Elm.VirtualDom (text, DOM) where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)

-- Define DOM effect type
foreign import data DOM :: Effect

foreign import text :: forall e. String -> Eff (dom :: DOM | e) Unit