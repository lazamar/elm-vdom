module Elm.Json where

import Prelude
import Data.Foreign (Foreign, F, ForeignError(ForeignError))
import Data.Foreign as Foreign

{- In PureScript a Json value is represented using the Foreign type.
	We define an alias named Decoder for any function that takes a 
	Foreign an transforms it into an F a.
-}
type Decoder a = Foreign -> F a

{-  Creates a decoder that will succeed with the value provided
-}
succeed :: ∀ a. a -> F a
succeed v = pure v

fail :: ∀ a. String -> F a
fail reason = Foreign.fail $ ForeignError reason