module Dominator.Decode where

import Prelude
import Data.Foreign (Foreign, F, ForeignError(ForeignError))
import Data.Foreign as Foreign

--| In PureScript a Json value is represented using the Foreign type.
--| We define an alias named Decoder for any function that takes a 
--| Foreign an transforms it into an F a.
type Decoder a = Foreign -> F a

--| Creates an `F a` that will succeed with the value passed.
succeed :: ∀ a. a -> F a
succeed v = pure v

--| Creates an `F a` that will fail with a custom error message
fail :: ∀ a. String -> F a
fail reason = Foreign.fail $ ForeignError reason