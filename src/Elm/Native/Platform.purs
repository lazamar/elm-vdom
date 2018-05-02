module Elm.Native.Platform where

import Prelude
import Elm.Native.Scheduler (Scheduler)
import Elm.Native.VirtualDom (DOM, Renderer, Node)
import Data.Tuple (Tuple)
import Control.Monad.Eff (Eff)
import Elm.Cmd (Cmd)

foreign import program :: forall msg model eff. 
 	Scheduler 
	-> Renderer
	-> (Tuple model (Array (Cmd (dom :: DOM | eff) msg))) 			
	-> (msg -> model -> Tuple model (Array (Cmd (dom :: DOM | eff) msg)))	
	-> (model -> Node msg) 											
	-> Eff (dom :: DOM | eff) Unit

