module Dominator.Operators (module Pipe, (!), type (!)) where

import Data.Function.Pipe as Pipe 
import Data.Tuple (Tuple(Tuple))

infixr 6 type Tuple as !
infixr 0 Tuple as !
