module Main where

import Prelude

import Async (Async, toAsync)
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Data.List ((:))
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Elm.Json.Decode as Json
import Elm.Json.Encode as Json
import Elm.Native.Platform (Cmd, program)
import Elm.Native.VirtualDom (style, on, node, text, DOM, Html, property)
import Data.Function ((#))

main :: Eff Effs Unit
main = 
	let 
		initialModel = "This goes on" 
	in
		program
			initialModel
			update
			view

type Model = String

data Msg = Clicked | DoNothing | LogSomething

type Effs = (console :: CONSOLE , dom :: DOM )



update :: Msg -> Model -> Tuple Model (Cmd Effs Msg)
update msg model =
	case msg of
		DoNothing ->
			Tuple model mempty

		LogSomething ->
			Tuple 
				model
				(log "Logging something!"
					# map (const DoNothing)
					# toAsync
					# flip (:) mempty
				)
		Clicked ->
			Tuple 
				(model <> "and on") 
				(log "Clicked!"
					# map (const LogSomething)
					# toAsync
					# flip (:) mempty
				)



view :: Model -> Html Msg
view model =
	node 
		"div" 
		( property "id" (Json.string "greeting") 
			: on "click" (Json.succeed Clicked)
			: style (Tuple "color" "blue" : mempty)
			: mempty
			)
		( text model : mempty )