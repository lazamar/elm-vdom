module Async where

import Prelude

import Control.Monad.Cont.Trans (ContT(ContT), runContT)
import Control.Monad.Eff (Eff, kind Effect)


type Async a b = ContT Unit (Eff a) b

toAsync :: forall a eff. (Eff eff a) -> Async eff a
toAsync eff = ContT $ \trymebaby -> do
	a <- eff
	trymebaby a
	
runAsync :: forall eff a. Async eff a -> (a -> Eff eff Unit) ->  Eff eff Unit
runAsync = runContT