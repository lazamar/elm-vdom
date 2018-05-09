--| Listening to HTML events
module Dominator.Html.Events
  ( onClick, onDoubleClick
  , onMouseDown, onMouseUp
  , onMouseEnter, onMouseLeave
  , onMouseOver, onMouseOut
  , onCheck
  , onInput,  onSubmit
  , onBlur, onFocus
  , on, onWithOptions, Options, defaultOptions
  , targetValue, targetChecked, keyCode
  ) where

import Prelude

import Dominator.Core.VirtualDom as VirtualDom
import Dominator.Html (Attribute)
import Dominator.Decode (Decoder, succeed)

import Data.Foreign.Index (readProp)
import Data.Foreign (readBoolean, readInt, readString)


-- MOUSE EVENTS


onClick :: ∀ msg. msg -> Attribute msg
onClick msg =
  on "click" (const $ succeed msg)


onDoubleClick :: ∀ msg. msg -> Attribute msg
onDoubleClick msg =
  on "dblclick" (const $ succeed msg)


onMouseDown :: ∀ msg. msg -> Attribute msg
onMouseDown msg =
  on "mousedown" (const $ succeed msg)


onMouseUp :: ∀ msg. msg -> Attribute msg
onMouseUp msg =
  on "mouseup" (const $ succeed msg)


onMouseEnter :: ∀ msg. msg -> Attribute msg
onMouseEnter msg =
  on "mouseenter" (const $ succeed msg)


onMouseLeave :: ∀ msg. msg -> Attribute msg
onMouseLeave msg =
  on "mouseleave" (const $ succeed msg)


onMouseOver :: ∀ msg. msg -> Attribute msg
onMouseOver msg =
  on "mouseover" (const $ succeed msg)


onMouseOut :: ∀ msg. msg -> Attribute msg
onMouseOut msg =
  on "mouseout" (const $ succeed msg)


-- FORM EVENTS


--| Capture `input` events for things like text fields or text areas.
--| It grabs the **string** value at `event.target.value`, so it will not work if
--| you need some other type of information. For example, if you want to track 
--| inputs on a range slider, make a custom handler with [`on`](#on).
--| 
--| For more details on how `onInput` works, check out [targetValue](#targetValue).
onInput :: ∀ msg. (String -> msg) -> Attribute msg
onInput tagger =
  on "input" (map tagger <<< targetValue)


--| Capture `change` events on checkboxes. It will grab the boolean value 
--| from `event.target.checked` on any input event.
--|
--| Check out [targetChecked](#targetChecked) for more details on how this works.
onCheck :: ∀ msg. (Boolean -> msg) -> Attribute msg
onCheck tagger =
  on "change" (map tagger targetChecked)


--| Capture a `submit` event with `preventDefault` in order to prevent the form from 
--| changing the page’s location. If you need different behavior, use `onWithOptions` 
--| to create a customized version of `onSubmit`.
onSubmit :: ∀ msg. msg -> Attribute msg
onSubmit msg =
  onWithOptions "submit" onSubmitOptions (const $ succeed msg)


onSubmitOptions :: Options
onSubmitOptions =
  VirtualDom.defaultOptions { preventDefault = true }


-- FOCUS EVENTS


onBlur :: ∀ msg. msg -> Attribute msg
onBlur msg =
  on "blur" (const $ succeed msg)


onFocus :: ∀ msg. msg -> Attribute msg
onFocus msg =
  on "focus" (const $ succeed msg)



-- CUSTOM EVENTS


--| Create a custom event listener. Normally this will not be necessary, but
--| you have the power! Here is how `onClick` is defined for example:
--|
--|     import Dominator.Decode (success) 
--|
--|     onClick :: ∀ msg. msg -> Attribute msg
--|     onClick message =
--|       on "click" (const $ success message)
--| 
--| The first argument is the event name in the same format as with JavaScript's
--| `addEventListener` function.
--| 
--| The second argument is a function that transforms `Foreign` values into `F a`.
--| It is aliased in Dominator.Decode as `Decoder`. 
--| When an event occurs, the decoder tries to turn the event object into a PureScript
--| value. If successful, the value is routed to your `update` function. In the
--| case of `onClick` we always just succeed with the given `message`.
on :: ∀ msg. String -> Decoder msg -> Attribute msg
on =
  VirtualDom.on


--| Same as `on` but you can set a few options.
onWithOptions :: ∀ msg. String -> Options -> Decoder msg -> Attribute msg
onWithOptions =
  VirtualDom.onWithOptions


--| Options for an event listener. If `stopPropagation` is true, it means the
--| event stops traveling through the DOM so it will not trigger any other event
--| listeners. If `preventDefault` is true, any built-in browser behavior related
--| to the event is prevented. For example, this is used with touch events when you
--| want to treat them as gestures of your own, not as scrolls.
type Options =
    { stopPropagation :: Boolean
    , preventDefault :: Boolean
    }


--| Everything is `False` by default.
--|
--|    defaultOptions =
--|        { stopPropagation = False
--|        , preventDefault = False
--|        }
defaultOptions :: Options
defaultOptions =
  VirtualDom.defaultOptions



-- COMMON DECODERS

--| A `Decoder` for grabbing `event.target.value`. We use this to define
--| `onInput` as follows:
--| 
--|     onInput :: ∀ msg. (String -> msg) -> Attribute msg
--|     onInput tagger =
--|       on "input" (map tagger targetValue)
--| 
--| You probably will never need this, but hopefully it gives some insights into
--| how to make custom event handlers.
targetValue :: Decoder String
targetValue f = 
  readProp "target" f 
  >>= readProp "value"
  >>= readString


--| A `Decoder` for grabbing `event.target.checked`. We use this to define
--| `onCheck` as follows:
--| 
--|     onCheck :: ∀ msg. (Boolean -> msg) -> Attribute msg
--|     onCheck tagger =
--|       on "input" (map tagger targetChecked)
targetChecked :: Decoder Boolean
targetChecked f =
  readProp "target" f
  >>= readProp "checked"
  >>= readBoolean


--| A `Decoder` for grabbing `event.keyCode`. This helps you define
--| keyboard listeners like this:
--| 
--|     onKeyUp :: ∀ msg. (Int -> msg) -> Attribute msg
--|     onKeyUp tagger =
--|       on "keyup" (map tagger keyCode)
keyCode :: Decoder Int
keyCode f =
  readProp "keyCode" f
  >>= readInt
