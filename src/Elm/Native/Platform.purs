module Elm.Native.Platform where

import Prelude
import Async (Async)
import Elm.Native.Scheduler (Scheduler, scheduler)
import Elm.Native.VirtualDom (DOM, Renderer, Html, normalRenderer)
import Data.Tuple (Tuple)
import Control.Monad.Eff (Eff)
import Data.List (List)

type Cmd eff a = List (Async eff a)

foreign import programImpl :: forall msg model eff. 
 	Scheduler 
	-> Renderer
	-> model 																-- Initial Model
	-> (msg -> model -> Tuple model (Cmd (dom :: DOM | eff) msg)) 	-- update
	-> (model -> Html msg) 												-- view
	-> Eff (dom :: DOM | eff) Unit

program :: forall msg model eff.
	model 																-- Initial Model
	-> (msg -> model -> Tuple model (Cmd (dom :: DOM | eff) msg)) 	-- update
	-> (model -> Html msg) 												-- view
	-> Eff (dom :: DOM | eff) Unit
program = programImpl scheduler normalRenderer