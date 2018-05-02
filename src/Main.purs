module Main where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Control.Monad.Aff (Aff)
import Data.Either (Either (Left, Right))
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Network.HTTP.Affjax (get, AJAX, Affjax)

import Elm.Html (DOM, program, Html, text, div)
import Elm.Html.Attributes (style, id)
import Elm.Html.Events (onClick)
import Elm.Operators ((!))
import Elm.Cmd (Cmd, makeCmd, fromAff)

main :: Eff Effs Unit
main = program
	{ init : init 
	, update : update
	, view : view
	}

type Model = String

data Msg = Clicked | DoNothing | LogSomething | LogNumber Int

type Effs = (console :: CONSOLE , dom :: DOM, ajax :: AJAX )


-- Subscription

foreign import repeat :: (Int -> Eff Effs Unit) -> Eff Effs Unit

init :: Tuple Model (Array (Cmd Effs Msg))
init = "This goes on" ! [ liftEff $ const DoNothing <$> log "Initiated!" ]


update :: Msg -> Model -> Tuple Model (Array (Cmd Effs Msg))
update msg model =
	case msg of
		DoNothing ->
			Tuple model mempty

		LogSomething ->
			model !
				[do 
					et <- fromAff getGoogleText
					liftEff $ log "Just after request"
					case et of 
						Right t -> liftEff $ log t
						Left err -> liftEff $ log "Error" >>= \_ -> logShow err
					liftEff $ log "After response handling" 
					pure DoNothing
				]
		Clicked ->
				(model <> "and on") !
				[ do
					liftEff $ log "Clicked!"
					num <- makeCmd repeat
					pure $ LogNumber num
				]

		LogNumber n ->
			model ! [ liftEff $ map (const DoNothing ) $ logShow n ]


getGoogleText :: forall t3. Aff  ( ajax :: AJAX | t3 ) String
getGoogleText = do
	r <- get "http://google.com"
	pure r.response

view :: Model -> Html Msg
view model =
	div 
		[ id "greeting"
		, onClick Clicked
		, style [ ("color" ! "blue") ]
		]
		[  text model ]