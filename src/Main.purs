module Main where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Data.List ((:))
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Async (Async)
import Elm.Json.Encode as Json
import Elm.Json.Decode as Json
import Elm.Native.Core as Core
import Elm.Native.VirtualDom 
		( style
		, on
		, node
		, text
		, DOM
		, Node
		, property)
import Elm.Native.Platform (program)


main :: forall e. Eff (console :: CONSOLE , dom :: DOM | e) Unit
main = 
	let 
		initialModel = "This goes on" 
	in
		program
			initialModel
			update
			view

type Model = String

data Msg = DoSomething | DoNothing

update msg model =
	Tuple (model <> " and on") mempty

view model =
	node 
		"div" 
		( property "id" (Json.string "greeting") 
			: on "click" (Json.succeed DoSomething)
			: style (Tuple "color" "blue" : mempty)
			: mempty
			)
		( text model : mempty )