module Elm.Html.Events
  ( onClick, onDoubleClick
  , onMouseDown, onMouseUp
  , onMouseEnter, onMouseLeave
  , onMouseOver, onMouseOut
  , onInput, onCheck, onSubmit
  , onBlur, onFocus
  , on, onWithOptions, Options, defaultOptions
  , targetValue, targetChecked, keyCode
  ) where

{-|
It is often helpful to create an [Union Type][] so you can have many different kinds
of events as seen in the [TodoMVC][] example.

[Union Type]:: forall msg. http:: forall msg.//elm-lang.org/learn/Union-Types.elm
[TodoMVC]:: forall msg. https:: forall msg.//github.com/evancz/elm-todomvc/blob/master/Todo.elm

# Mouse Helpers
@docs onClick, onDoubleClick,
      onMouseDown, onMouseUp,
      onMouseEnter, onMouseLeave,
      onMouseOver, onMouseOut

# Form Helpers
@docs onInput, onCheck, onSubmit

# Focus Helpers
@docs onBlur, onFocus

# Custom Event Handlers
@docs on, onWithOptions, Options, defaultOptions

# Custom Decoders
@docs targetValue, targetChecked, keyCode
-}

import Prelude
import Elm.Html (Attribute)
import Elm.Json.Decode as Json
import Elm.Native.VirtualDom as VirtualDom



-- MOUSE EVENTS


{-|-}
onClick :: forall msg. msg -> Attribute msg
onClick msg =
  on "click" (Json.succeed msg)


{-|-}
onDoubleClick :: forall msg. msg -> Attribute msg
onDoubleClick msg =
  on "dblclick" (Json.succeed msg)


{-|-}
onMouseDown :: forall msg. msg -> Attribute msg
onMouseDown msg =
  on "mousedown" (Json.succeed msg)


{-|-}
onMouseUp :: forall msg. msg -> Attribute msg
onMouseUp msg =
  on "mouseup" (Json.succeed msg)


{-|-}
onMouseEnter :: forall msg. msg -> Attribute msg
onMouseEnter msg =
  on "mouseenter" (Json.succeed msg)


{-|-}
onMouseLeave :: forall msg. msg -> Attribute msg
onMouseLeave msg =
  on "mouseleave" (Json.succeed msg)


{-|-}
onMouseOver :: forall msg. msg -> Attribute msg
onMouseOver msg =
  on "mouseover" (Json.succeed msg)


{-|-}
onMouseOut :: forall msg. msg -> Attribute msg
onMouseOut msg =
  on "mouseout" (Json.succeed msg)



-- FORM EVENTS


{-| Capture [input](https:: forall msg.//developer.mozilla.org/en-US/docs/Web/Events/input)
events for things like text fields or text areas.

It grabs the **string** value at `event.target.value`, so it will not work if
you need some other type of information. For example, if you want to track 
inputs on a range slider, make a custom handler with [`on`](#on).

For more details on how `onInput` works, check out [targetValue](#targetValue).
-}
onInput :: forall msg. (String -> msg) -> Attribute msg
onInput tagger =
  on "input" (map tagger targetValue)


{-| Capture [change](https:: forall msg.//developer.mozilla.org/en-US/docs/Web/Events/change)
events on checkboxes. It will grab the boolean value from `event.target.checked`
on any input event.

Check out [targetChecked](#targetChecked) for more details on how this works.
-}
onCheck :: forall msg. (Boolean -> msg) -> Attribute msg
onCheck tagger =
  on "change" (map tagger targetChecked)


{-| Capture a [submit](https:: forall msg.//developer.mozilla.org/en-US/docs/Web/Events/submit)
event with [`preventDefault`](https:: forall msg.//developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault)
in order to prevent the form from changing the page’s location. If you need
different behavior, use `onWithOptions` to create a customized version of
`onSubmit`.
-}
onSubmit :: forall msg. msg -> Attribute msg
onSubmit msg =
  onWithOptions "submit" onSubmitOptions (Json.succeed msg)


onSubmitOptions :: forall msg. Options
onSubmitOptions =
  defaultOptions { preventDefault = true }


-- FOCUS EVENTS


{-|-}
onBlur :: forall msg. msg -> Attribute msg
onBlur msg =
  on "blur" (Json.succeed msg)


{-|-}
onFocus :: forall msg. msg -> Attribute msg
onFocus msg =
  on "focus" (Json.succeed msg)



-- CUSTOM EVENTS


{-| Create a custom event listener. Normally this will not be necessary, but
you have the power! Here is how `onClick` is defined for example:: forall msg.

    import Json.Decode as Json

    onClick :: forall msg. msg -> Attribute msg
    onClick message =
      on "click" (Json.succeed message)

The first argument is the event name in the same format as with JavaScript's
[`addEventListener`][aEL] function.

The second argument is a JSON decoder. Read more about these [here][decoder].
When an event occurs, the decoder tries to turn the event object into an Elm
value. If successful, the value is routed to your `update` function. In the
case of `onClick` we always just succeed with the given `message`.

If this is confusing, work through the [Elm Architecture Tutorial][tutorial].
It really does help!

[aEL]:: forall msg. https:: forall msg.//developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
[decoder]:: forall msg. http:: forall msg.//package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode
[tutorial]:: forall msg. https:: forall msg.//github.com/evancz/elm-architecture-tutorial/
-}
on :: forall msg. String -> Json.Decoder msg -> Attribute msg
on =
  VirtualDom.on


{-| Same as `on` but you can set a few options.
-}
onWithOptions :: forall msg. String -> Options -> Json.Decoder msg -> Attribute msg
onWithOptions =
  VirtualDom.onWithOptions


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
  VirtualDom.defaultOptions



-- COMMON DECODERS


{-| A `Json.Decoder` for grabbing `event.target.value`. We use this to define
`onInput` as follows:: forall msg.

    import Json.Decode as Json

    onInput :: forall msg. (String -> msg) -> Attribute msg
    onInput tagger =
      on "input" (map tagger targetValue)

You probably will never need this, but hopefully it gives some insights into
how to make custom event handlers.
-}
targetValue :: forall msg. Json.Decoder String
targetValue =
  Json.at ["target", "value"] Json.string


{-| A `Json.Decoder` for grabbing `event.target.checked`. We use this to define
`onCheck` as follows:: forall msg.

    import Json.Decode as Json

    onCheck :: forall msg. (Boolean -> msg) -> Attribute msg
    onCheck tagger =
      on "input" (map tagger targetChecked)
-}
targetChecked :: forall msg. Json.Decoder Boolean
targetChecked =
  Json.at ["target", "checked"] Json.bool


{-| A `Json.Decoder` for grabbing `event.keyCode`. This helps you define
keyboard listeners like this:: forall msg.

    import Json.Decode as Json

    onKeyUp :: forall msg. (Int -> msg) -> Attribute msg
    onKeyUp tagger =
      on "keyup" (map tagger keyCode)

**Note:: forall msg.** It looks like the spec is moving away from `event.keyCode` and
towards `event.key`. Once this is supported in more browsers, we may add
helpers here for `onKeyUp`, `onKeyDown`, `onKeyPress`, etc.
-}
keyCode :: forall msg. Json.Decoder Int
keyCode =
  Json.field "keyCode" Json.int