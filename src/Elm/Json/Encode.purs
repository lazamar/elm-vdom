module Elm.Json.Encode 
  ( Value 
  , encode 
  , string
  , int
  , float
  , bool
  , null 
  , object) 
  where
  -- , list, array


import Data.List (List)
import Data.Tuple (Tuple)

{-| Library for turning Elm values into Json values.

# Encoding
@docs encode, Value

# Primitives
@docs string, int, float, bool, null

# Arrays
@docs list, array

# Objects
@docs object
-}


{-| Represents a JavaScript value.
-}
data Value = Value


{-| Convert a `Value` into a prettified string. The first argument specifies
the amount of indentation in the resulting string.

    person =
        object
          [ ("name", string "Tom")
          , ("age", int 42)
          ]

    compact = encode 0 person
    -- {"name":"Tom","age":42}

    readable = encode 4 person
    -- {
    --     "name": "Tom",
    --     "age": 42
    -- }
-}
foreign import encode :: Int -> Value -> String

foreign import identity :: forall a. a -> Value

{-|-}
string :: String -> Value
string = identity


{-|-}
int :: Int -> Value
int = identity


{-| Encode a Float. `Infinity` and `NaN` are encoded as `null`.
-}
float :: Number -> Value
float = identity


{-|-}
bool :: Boolean -> Value
bool = identity

foreign import encodeNull :: Value

{-|-}
null :: Value
null = encodeNull

foreign import encodeObject :: List (Tuple String Value) -> Value

{-|-}
object :: List (Tuple String Value) -> Value
object = encodeObject

-- {-|-}
-- array :: Array Value -> Value
-- array =
--     Native.Json.encodeArray


-- {-|-}
-- list :: List Value -> Value
-- list =
--     Native.Json.encodeList