--| Convenience functions for Tuple creation and function application
module Dominator.Operators (module Pipe, (!), type (!)) where

import Data.Function.Pipe as Pipe 
import Data.Tuple (Tuple(Tuple))


--| PureScript doesn't have literal Tuple syntax. This infix Operator
--| makes Tuple creation and descructuring look more similar to Haskell 
--| and Elm tuple syntax.
--|
--| Here is an example
--|```
--| coordinates :: Tuple Int Int 
--| coordinates = (5 ! 6)
--|```
infixr 0 Tuple as !


--| Makes Tuple types look more similar to Haskell and Elm tuples.
--|
--| Example
--|```
--| coordinates :: Int ! Int 
--| coordinates = Tuple 5 6
--|```
infixr 6 type Tuple as !

