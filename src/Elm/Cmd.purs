module Elm.Cmd where

import Prelude

import Control.Monad.Cont.Trans (ContT(ContT))
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Exception (Error)
import Control.Monad.Aff (Aff, runAff_, effCanceler, makeAff)
import Data.Either (Either(Right, Left))

-- Aff is equivalent to Tasks in Elm

type Cmd eff b = ContT Unit (Eff eff) b

makeCmd :: ∀ a eff. ((a -> Eff eff Unit) -> Eff eff Unit) -> Cmd eff a
makeCmd = ContT

fromAff :: ∀ eff a. Aff eff a -> Cmd eff (Either Error a)
fromAff aff = makeCmd $ flip runAff_ $ aff 

runAff :: ∀ eff a msg. (Error -> msg) -> (a -> msg) -> Aff eff a -> Cmd eff msg
runAff onError onSuccess aff = do
	e <- fromAff aff
	case e of
		Right v -> pure $ onSuccess v
		Left v -> pure $ onError v