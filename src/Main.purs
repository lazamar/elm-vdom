module Main where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Data.List ((:))
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Elm.Json.Decode as Json
import Elm.Json.Encode as Json
import Elm.Native.Platform (Cmd, program)
import Elm.Native.VirtualDom (style, on, node, text, DOM, Html, property)
import Network.HTTP.Affjax (get, AJAX)
import Async (fromAff)

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

type Effs = (console :: CONSOLE , dom :: DOM, ajax :: AJAX)

update :: Msg -> Model -> Tuple Model (Cmd Effs Msg)
update msg model =
	case msg of
		DoNothing ->
			Tuple model mempty

		LogSomething ->
			Tuple 
				model
				(pure $ do 
					a <- fromAff $ get "http://google.com"
					liftEff $ log "Logging something"	
					liftEff $ logShow $ (\v -> v.response :: String) <$> a
					pure DoNothing
				)
		Clicked ->
			Tuple 
				(model <> "and on") 
				(pure $ liftEff do
					log "Clicked!"
					pure LogSomething
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