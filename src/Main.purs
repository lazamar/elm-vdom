module Main where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.Class (liftAff)
import Data.Either (Either (Left, Right))
import Data.List ((:))
import Data.Monoid (mempty)
import Data.Tuple (Tuple(Tuple))
import Network.HTTP.Affjax (get, AJAX, Affjax)

import Elm.Html (DOM, program, Html, text, div)
import Elm.Html.Attributes (style, id)
import Elm.Html.Events (onClick)
import Elm.Operators ((!))
import Elm.Async (Async, makeAsync, fromAff)

main :: forall a. Eff ( Effs a ) Unit
main = program
	{ init : init 
	, update : update
	, view : view
	}

type Model = String

data Msg = Clicked | DoNothing | LogSomething | LogNumber Int

type Effs a = (console :: CONSOLE , dom :: DOM, ajax :: AJAX | a)


-- Subscription

foreign import repeat :: forall a. (Int -> Eff (Effs a) Unit) -> Eff (Effs a) Unit

init :: forall a. Tuple Model (Array (Async ( Effs a ) Msg))
init = "This goes on" ! [ liftEff $ const DoNothing <$> log "Initiated!" ]


update :: forall a. Msg -> Model -> Tuple Model (Array (Async ( Effs a ) Msg))
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
					num <- makeAsync repeat
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