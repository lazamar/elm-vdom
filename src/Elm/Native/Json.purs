module Elm.Native.Json where

import Data.List (List)
import Data.Tuple (Tuple)
import Data.Functor (class Functor)

data Value = Value
data Decoder a = Decoder

instance functorDecoder :: Functor Decoder where
	map = map1

foreign import encode :: Int -> Value -> String
-- foreign import runOnString ::
-- foreign import run ::

-- foreign import decodeNull ::
foreign import decodePrimitive :: forall a. String -> Decoder a
-- foreign import decodeContainer :: forall a. String -> Decoder a

foreign import decodeField :: forall a. String -> Decoder a -> Decoder a
-- foreign import decodeIndex ::

foreign import map1 :: forall a value. (a -> value) -> Decoder a -> Decoder value
-- foreign import map2 ::
-- foreign import map3 ::
-- foreign import map4 ::
-- foreign import map5 ::
-- foreign import map6 ::
-- foreign import map7 ::
-- foreign import map8 ::
-- foreign import decodeKeyValuePairs ::

-- foreign import andThen ::
foreign import fail :: forall a. String -> Decoder a
foreign import succeed :: forall a. a -> Decoder a
-- foreign import oneOf ::

foreign import identity :: forall a. a -> Value

foreign import encodeNull :: Value
-- foreign import encodeArray ::
-- foreign import encodeList ::
foreign import encodeObject :: List (Tuple String Value) -> Value

-- foreign import equality ::