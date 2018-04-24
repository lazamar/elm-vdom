module Main where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Elm.VirtualDom (anything, renderOnce, node, text, DOM, Node, property)
import Elm.Json.Encode as Json
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Data.List ((:))
import Elm.Native.Core as Core

main :: forall e. Eff (console :: CONSOLE , dom :: DOM | e) Unit
main = do
	let
		initialModel = "Initial Model" 
		view m =
			node 
				"div" 
				( property "id" (Json.string "greeting") : mempty) 
				( text m : mempty )

	renderOnce ( view :: String -> Node Unit) initialModel
	anything (1 : 2 : mempty)	
  	log "Hello sucker!" 
