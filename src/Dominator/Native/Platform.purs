module Dominator.Native.Platform where

import Prelude
import Dominator.Native.Scheduler (Scheduler)
import Dominator.Native.VirtualDom (DOM, Renderer, Node)
import Dominator.Cmd (Cmds)

import Data.Maybe (Maybe)
import Data.Foreign (Foreign)
import Data.Tuple (Tuple)
import Control.Monad.Eff (Eff)

type HtmlElement = Foreign 

foreign import program :: forall msg model eff. 
	Maybe HtmlElement
 	-> Scheduler 
	-> Renderer
	-> (Tuple model (Cmds (dom :: DOM | eff) msg)) 			
	-> (msg -> model -> Tuple model (Cmds (dom :: DOM | eff) msg))	
	-> (model -> Node msg) 											
	-> Eff (dom :: DOM | eff) Unit

