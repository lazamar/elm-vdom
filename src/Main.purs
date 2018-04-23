module Main where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Elm.VirtualDom (anything, txt, node, text, DOM, Node, property)
import Elm.Json.Encode as Json
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Data.List ((:))

main :: forall e. Eff (console :: CONSOLE , dom :: DOM | e) Unit
main = do
	let 
		nd = node 
			"div" 
			( property "id" (Json.string "greeting") : mempty) 
			( text "Hello!" : mempty )

	txt ( nd :: Node Unit)
	anything (1 : 2 : mempty)	
  	log "Hello sucker!" 
