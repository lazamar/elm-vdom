module Elm.Native.Platform where

import Prelude
import Elm.Native.Scheduler (Scheduler, scheduler)
import Elm.Native.VirtualDom (DOM, Renderer, Node, normalRenderer)
import Data.Tuple (Tuple(Tuple))
import Control.Monad.Eff (Eff)
import Async (Async)
import Data.List (List, fromFoldable)

type Cmd eff a = Array (Async eff a)

infixr 0 Tuple as !

foreign import programImpl :: forall msg model eff. 
 	Scheduler 
	-> Renderer
	-> model 														-- Initial Model
	-> (msg -> model -> Tuple model (List (Async (dom :: DOM | eff) msg)))	-- update
	-> (model -> Node msg) 											-- view
	-> Eff (dom :: DOM | eff) Unit

program :: forall msg model eff.
	model 															-- Initial Model
	-> (msg -> model -> Tuple model (Cmd (dom :: DOM | eff) msg)) 	-- update
	-> (model -> Node msg) 											-- view
	-> Eff (dom :: DOM | eff) Unit
program model updateRaw view = 
	let
		-- Convert Array (Eff) into List (Eff) 
		update msg m = map fromFoldable $ updateRaw msg m	
	in
		programImpl 
			scheduler 
			normalRenderer
			model
			update
			view

