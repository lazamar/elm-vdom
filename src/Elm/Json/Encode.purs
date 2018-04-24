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
import Elm.Native.Json as Elm.Native.Json

{-| Library for turning Elm values into Json values.
-}
type Value = Elm.Native.Json.Value

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
encode :: Int -> Value -> String
encode = Elm.Native.Json.encode

{-|-}
string :: String -> Value
string = Elm.Native.Json.identity


{-|-}
int :: Int -> Value
int = Elm.Native.Json.identity


{-| Encode a Float. `Infinity` and `NaN` are encoded as `null`.
-}
float :: Number -> Value
float = Elm.Native.Json.identity


{-|-}
bool :: Boolean -> Value
bool = Elm.Native.Json.identity

{-|-}
null :: Value
null = Elm.Native.Json.encodeNull

{-|-}
object :: List (Tuple String Value) -> Value
object = Elm.Native.Json.encodeObject

-- {-|-}
-- array :: Array Value -> Value
-- array =
--     Native.Json.encodeArray


-- {-|-}
-- list :: List Value -> Value
-- list =
--     Native.Json.encodeList