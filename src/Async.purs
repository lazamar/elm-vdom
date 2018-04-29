module Async where

import Prelude

import Control.Monad.Cont.Trans (ContT(ContT))
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Aff (Aff, runAff_)
import Control.Monad.Eff.Exception (Error)
import Data.Either (Either)

type Async a b = ContT Unit (Eff a) b

makeAsync :: forall a eff. ((a -> Eff eff Unit) -> Eff eff Unit) -> Async eff a
makeAsync = ContT

fromAff :: forall eff a. Aff eff a -> Async eff (Either Error a)
fromAff aff = makeAsync $ flip runAff_ $ aff 
