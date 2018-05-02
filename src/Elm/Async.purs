module Elm.Async where

import Prelude

import Control.Monad.Cont.Trans (ContT(ContT))
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Exception (Error)
import Control.Monad.Aff (Aff, runAff_, effCanceler, makeAff)
import Data.Either (Either(Right, Left))

-- Aff is equivalent to Tasks in Elm

type Async a b = ContT Unit (Eff a) b
makeAsync :: ∀ a eff. ((a -> Eff eff Unit) -> Eff eff Unit) -> Async eff a
makeAsync = ContT

fromAff :: ∀ eff a. Aff eff a -> Async eff (Either Error a)
fromAff aff = makeAsync $ flip runAff_ $ aff 

runAff :: ∀ eff a msg. (Error -> msg) -> (a -> msg) -> Aff eff a -> Async eff msg
runAff onError onSuccess aff = do
	e <- fromAff aff
	case e of
		Right v -> pure $ onSuccess v
		Left v -> pure $ onError v