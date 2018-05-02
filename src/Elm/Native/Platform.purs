module Elm.Native.Platform where

import Prelude
import Elm.Native.Scheduler (Scheduler)
import Elm.Native.VirtualDom (DOM, Renderer, Node)
import Data.Tuple (Tuple)
import Control.Monad.Eff (Eff)
import Elm.Async (Async)

foreign import program :: forall msg model eff. 
 	Scheduler 
	-> Renderer
	-> (Tuple model (Array (Async (dom :: DOM | eff) msg))) 		-- Initial Model
	-> (msg -> model -> Tuple model (Array (Async (dom :: DOM | eff) msg)))	-- update
	-> (model -> Node msg) 											-- view
	-> Eff (dom :: DOM | eff) Unit

