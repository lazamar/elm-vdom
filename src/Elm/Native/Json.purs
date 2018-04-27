module Elm.Native.Json where

import Elm.Native.Core as Core
import Elm.Native.Utils as Utils
import Data.List (List)
import Data.Tuple (Tuple)

data Value = Value
data Decoder a = Decoder

foreign import encode :: Int -> Value -> String
-- foreign import runOnString ::
-- foreign import run ::

-- foreign import decodeNull ::
-- foreign import decodePrimitive ::
-- foreign import decodeContainer ::

-- foreign import decodeField ::
-- foreign import decodeIndex ::

-- foreign import map1 ::
-- foreign import map2 ::
-- foreign import map3 ::
-- foreign import map4 ::
-- foreign import map5 ::
-- foreign import map6 ::
-- foreign import map7 ::
-- foreign import map8 ::
-- foreign import decodeKeyValuePairs ::

-- foreign import andThen ::
-- foreign import fail ::
foreign import succeed :: forall a. a -> Decoder a
-- foreign import oneOf ::

foreign import identity :: forall a. a -> Value

foreign import encodeNull :: Value
-- foreign import encodeArray ::
-- foreign import encodeList ::
foreign import encodeObject :: List (Tuple String Value) -> Value

-- foreign import equality ::