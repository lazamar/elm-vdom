module Elm.Native.VirtualDom 
  ( DOM
  , Node
  , Html
  , Property
  , Renderer
  , normalRenderer
  , text
  , node
  , property
  , attribute
  , style
  , on
  ) where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Data.List (List, fromFoldable)
import Data.Tuple (Tuple)
import Elm.Json.Decode as Json
import Elm.Json.Encode as Json
import Data.Functor (class Functor, map)

-- Define DOM effect type
foreign import data DOM :: Effect

-- type ViewFunc msg model = model -> Node msg

foreign import renderOnce :: forall msg model a. 
  (model -> Node msg) 
  -> model 
  -> Eff (dom :: DOM | a ) Unit


data Renderer = Renderer

foreign import normalRenderer :: Renderer

-- module VirtualDom exposing
--   ( Node
--   , text, node
--   , Property, property, attribute, attributeNS, mapProperty
--   , style
--   , on, onWithOptions, Options, defaultOptions
--   , map
--   , lazy, lazy2, lazy3
--   , keyedNode
--   , program, programWithFlags
--   )

-- import Json.Decode as Json
-- import Native.VirtualDom
-- import VirtualDom.Debug as Debug


{-| An immutable chunk of data representing a DOM node.
  This can be HTML or SVG.
-}

data Node msg = Node

instance functorNode :: Functor Node where
  map f n = nodeMap f n

type Html msg = Node msg

instance showNode :: Show (Node msg) where
  show Node = "Node"

{-| Create a DOM node with a tag name, a list of HTML properties that can
include styles and event listeners, a list of CSS properties like `color`, and
a list of child nodes.

    import Json.Encode as Json

    hello : Node msg
    hello =
      node "div" [] [ text "Hello!" ]

    greeting : Node msg
    greeting =
      node "div"
        [ property "id" (Json.string "greeting") ]
        [ text "Hello!" ]
-}
foreign import node_ :: forall msg. String -> List (Property msg) -> List (Node msg) -> Node msg

node :: forall msg. String -> Array (Property msg) -> Array (Node msg) -> Node msg
node s p c =
  node_ s (fromFoldable p) (fromFoldable c)

{-| Just put plain text in the DOM. It will escape the string so that it appears
exactly as you specify.

    text "Hello World!"
-}

foreign import text :: forall msg. String -> Node msg



{-| This function is useful when nesting components with [the Elm
Architecture](https://github.com/evancz/elm-architecture-tutorial/). It lets
you transform the messages produced by a subtree.

Say you have a node named `button` that produces `()` values when it is
clicked. To get your model updating properly, you will probably want to tag
this `()` value like this:

    type Msg = Click | ...

    update msg model =
      case msg of
        Click ->
          ...

    view model =
      map (\_ -> Click) button

So now all the events produced by `button` will be transformed to be of type
`Msg` so they can be handled by your update function!
-}
foreign import nodeMap :: forall a msg. (a -> msg) -> Node a -> Node msg



-- -- PROPERTIES


{-| When using HTML and JS, there are two ways to specify parts of a DOM node.

  1. Attributes &mdash; You can set things in HTML itself. So the `class`
     in `<div class="greeting"></div>` is called an *attribute*.

  2. Properties &mdash; You can also set things in JS. So the `className`
     in `div.className = 'greeting'` is called a *property*.

So the `class` attribute corresponds to the `className` property. At first
glance, perhaps this distinction is defensible, but it gets much crazier.
*There is not always a one-to-one mapping between attributes and properties!*
Yes, that is a true fact. Sometimes an attribute exists, but there is no
corresponding property. Sometimes changing an attribute does not change the
underlying property. For example, as of this writing, the `webkit-playsinline`
attribute can be used in HTML, but there is no corresponding property!
-}

data Property msg = Property

instance showProperty :: Show (Property msg) where
  show Property = "Property"


{-| Create arbitrary *properties*.

    import JavaScript.Encode as Json

    greeting : Html
    greeting =
        node "div" [ property "className" (Json.string "greeting") ] [
          text "Hello!"
        ]

Notice that you must give the *property* name, so we use `className` as it
would be in JavaScript, not `class` as it would appear in HTML.
-}
foreign import property :: forall msg. String -> Json.Value -> Property msg


{-| Create arbitrary HTML *attributes*. Maps onto JavaScript’s `setAttribute`
function under the hood.

    greeting : Html
    greeting =
        node "div" [ attribute "class" "greeting" ] [
          text "Hello!"
        ]

Notice that you must give the *attribute* name, so we use `class` as it would
be in HTML, not `className` as it would appear in JS.
-}
foreign import attribute :: forall msg. String -> String -> Property msg


-- {-| Would you believe that there is another way to do this?! This corresponds
-- to JavaScript's `setAttributeNS` function under the hood. It is doing pretty
-- much the same thing as `attribute` but you are able to have "namespaced"
-- attributes. This is used in some SVG stuff at least.
-- -}
-- attributeNS : String -> String -> String -> Property msg
-- attributeNS =
--   Native.VirtualDom.attributeNS


-- {-| Transform the messages produced by a `Property`.
-- -}
-- mapProperty : (a -> b) -> Property a -> Property b
-- mapProperty =
--   Native.VirtualDom.mapProperty


-- | Specify a list of styles.

--     myStyle : Property msg
--     myStyle =
--       style
--         [ ("backgroundColor", "red")
--         , ("height", "90px")
--         , ("width", "100%")
--         ]

--     greeting : Node msg
--     greeting =
--       node "div" [ myStyle ] [ text "Hello!" ]


foreign import style_ :: forall msg. List (Tuple String String) -> Property msg

style :: forall msg. Array (Tuple String String) -> Property msg
style a = style_ $ fromFoldable a

-- -- EVENTS


{-| Create a custom event listener.

    import Json.Decode as Json

    onClick : msg -> Property msg
    onClick msg =
      on "click" (Json.succeed msg)

You first specify the name of the event in the same format as with JavaScript’s
`addEventListener`. Next you give a JSON decoder, which lets you pull
information out of the event object. If the decoder succeeds, it will produce
a message and route it to your `update` function.
-}
on :: forall msg. String -> Json.Decoder msg -> Property msg
on eventName decoder =
  onWithOptions eventName defaultOptions decoder


{-| Same as `on` but you can set a few options.
-}
foreign import onWithOptions :: forall msg. String -> Options -> Json.Decoder msg -> Property msg


{-| Options for an event listener. If `stopPropagation` is true, it means the
event stops traveling through the DOM so it will not trigger any other event
listeners. If `preventDefault` is true, any built-in browser behavior related
to the event is prevented. For example, this is used with touch events when you
want to treat them as gestures of your own, not as scrolls.
-}
type Options =
  { stopPropagation :: Boolean
  , preventDefault :: Boolean
  }


{-| Everything is `False` by default.

    defaultOptions =
        { stopPropagation = False
        , preventDefault = False
        }
-}
defaultOptions :: Options
defaultOptions =
  { stopPropagation : false
  , preventDefault : false
  }



-- -- OPTIMIZATION


-- {-| A performance optimization that delays the building of virtual DOM nodes.

-- Calling `(view model)` will definitely build some virtual DOM, perhaps a lot of
-- it. Calling `(lazy view model)` delays the call until later. During diffing, we
-- can check to see if `model` is referentially equal to the previous value used,
-- and if so, we just stop. No need to build up the tree structure and diff it,
-- we know if the input to `view` is the same, the output must be the same!
-- -}
-- lazy : (a -> Node msg) -> a -> Node msg
-- lazy =
--   Native.VirtualDom.lazy


-- {-| Same as `lazy` but checks on two arguments.
-- -}
-- lazy2 : (a -> b -> Node msg) -> a -> b -> Node msg
-- lazy2 =
--   Native.VirtualDom.lazy2


-- {-| Same as `lazy` but checks on three arguments.
-- -}
-- lazy3 : (a -> b -> c -> Node msg) -> a -> b -> c -> Node msg
-- lazy3 =
--   Native.VirtualDom.lazy3


-- {-| Works just like `node`, but you add a unique identifier to each child
-- node. You want this when you have a list of nodes that is changing: adding
-- nodes, removing nodes, etc. In these cases, the unique identifiers help make
-- the DOM modifications more efficient.
-- -}
-- keyedNode : String -> Array (Property msg) -> Array ( String, Node msg ) -> Node msg
-- keyedNode =
--   Native.VirtualDom.keyedNode



-- -- PROGRAMS


-- {-| Check out the docs for [`Html.App.program`][prog].
-- It works exactly the same way.

-- [prog]: http://package.elm-lang.org/packages/elm-lang/html/latest/Html-App#program
-- -}
-- program
--   : { init : (model, Cmd msg)
--     , update : msg -> model -> (model, Cmd msg)
--     , subscriptions : model -> Sub msg
--     , view : model -> Node msg
--     }
--   -> Program Never model msg
-- program impl =
--   Native.VirtualDom.program Debug.wrap impl


-- {-| Check out the docs for [`Html.App.programWithFlags`][prog].
-- It works exactly the same way.

-- [prog]: http://package.elm-lang.org/packages/elm-lang/html/latest/Html-App#programWithFlags
-- -}
-- programWithFlags
--   : { init : flags -> (model, Cmd msg)
--     , update : msg -> model -> (model, Cmd msg)
--     , subscriptions : model -> Sub msg
--     , view : model -> Node msg
--     }
--   -> Program flags model msg
-- programWithFlags impl =
--   Native.VirtualDom.programWithFlags Debug.wrapWithFlags impl