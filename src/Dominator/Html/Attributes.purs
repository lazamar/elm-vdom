module Dominator.Html.Attributes
  ( style, property, attribute
  , class_, classList, id, title, hidden
  , type_, value, defaultValue, checked, placeholder, selected
  , accept, acceptCharset, action, autocomplete, autofocus
  , disabled, enctype, formaction, list, maxlength, minlength, method, multiple
  , name, novalidate, pattern, readonly, required, size, for, form
  , max, min, step
  , cols, rows, wrap
  , href, target, download, downloadAs, hreflang, media, ping, rel
  , ismap, usemap, shape, coords
  , src, height, width, alt
  , autoplay, controls, loop, preload, poster, default, kind, srclang
  , sandbox, seamless, srcdoc
  , reversed, start
  , align, colspan, rowspan, headers, scope
  , async, charset, content, defer, httpEquiv, language, scoped
  , accesskey, contenteditable, contextmenu, dir, draggable, dropzone
  , itemprop, lang, spellcheck, tabindex
  , challenge, keytype
  , cite, datetime, pubdate, manifest
  ) where

{-| Helper functions for HTML attributes. They are organized roughly by
category. Each attribute is labeled with the HTML tags it can be used with, so
just search the page for `video` if you want video stuff.

If you cannot find what you are looking for, go to the [Custom
Attributes](#custom-attributes) section to learn how to create new helpers.

# Primitives
@docs style, property, attribute, map

# Super Common Attributes
@docs class, classList, id, title, hidden

# Inputs
@docs type_, value, defaultValue, checked, placeholder, selected

## Input Helpers
@docs accept, acceptCharset, action, autocomplete, autofocus,
    disabled, enctype, formaction, list, maxlength, minlength, method, multiple,
    name, novalidate, pattern, readonly, required, size, for, form

## Input Ranges
@docs max, min, step

## Input Text Areas
@docs cols, rows, wrap


# Links and Areas
@docs href, target, download, downloadAs, hreflang, media, ping, rel

## Maps
@docs ismap, usemap, shape, coords


# Embedded Content
@docs src, height, width, alt

## Audio and Video
@docs autoplay, controls, loop, preload, poster, default, kind, srclang

## iframes
@docs sandbox, seamless, srcdoc

# Ordered Lists
@docs reversed, start

# Tables
@docs align, colspan, rowspan, headers, scope

# Header Stuff
@docs async, charset, content, defer, httpEquiv, language, scoped

# Less Common Global Attributes
Attributes that can be attached to any HTML tag but are less commonly used.
@docs accesskey, contenteditable, contextmenu, dir, draggable, dropzone,
      itemprop, lang, spellcheck, tabindex

# Key Generation
@docs challenge, keytype

# Miscellaneous
@docs cite, datetime, pubdate, manifest

-}

import Prelude
import Dominator.Html (Attribute)
import Dominator.Core.VirtualDom as VirtualDom

import Data.Foreign (Foreign, toForeign)
import Data.List (fromFoldable)
import Data.Tuple (Tuple, fst, snd)
import Data.Foldable (intercalate)
import Data.Function.Pipe ((|>))
import Data.Array (filter)

-- This library does not include low, high, or optimum because the idea of a
-- `meter` is just too crazy.



-- PRIMITIVES


{-| Specify a list of styles.

    myStyle :: ∀ msg. Attribute msg
    myStyle =
      style
        [ ("backgroundColor", "red")
        , ("height", "90px")
        , ("width", "100%")
        ]

    greeting :: ∀ msg. Html msg
    greeting =
      div [ myStyle ] [ text "Hello!" ]

There is no `Html.Styles` module because best practices for working with HTML
suggest that this should primarily be specified in CSS files. So the general
recommendation is to use this function lightly.
-}
style :: ∀ msg. Array (Tuple String String) -> Attribute msg
style l =
  VirtualDom.style $ fromFoldable l


{-| This function makes it easier to build a space-separated class attribute.
Each class can easily be added and removed depending on the boolean value it
is paired with. For example, maybe we want a way to view notices:: ∀ msg.

    viewNotice :: ∀ msg. Notice -> Html msg
    viewNotice notice =
      div
        [ classList
            [ ("notice", True)
            , ("notice-important", notice.isImportant)
            , ("notice-seen", notice.isSeen)
            ]
        ]
        [ text notice.content ]
-}
classList :: ∀ msg. Array (Tuple String Boolean) -> Attribute msg
classList clist =
  clist
    |> filter snd
    |> map fst
    |> intercalate " "
    |> class_



-- CUSTOM ATTRIBUTES


{-| Create *properties*, like saying `domNode.className = 'greeting'` in
JavaScript.

    import Json.Encode as Encode

    class :: ∀ msg. String -> Attribute msg
    class name =
      property "className" (Encode.string name)

Read more about the difference between properties and attributes [here][].

[here]:: ∀ msg. https:: ∀ msg.//github.com/elm-lang/html/blob/master/properties-vs-attributes.md
-}
property :: ∀ msg. String -> Foreign -> Attribute msg
property =
  VirtualDom.property


stringProperty :: ∀ msg. String -> String -> Attribute msg
stringProperty name_ string =
  property name_ (toForeign string)


boolProperty :: ∀ msg. String -> Boolean -> Attribute msg
boolProperty name_ bool =
  property name_ (toForeign bool)


{-| Create *attributes*, like saying `domNode.setAttribute('class', 'greeting')`
in JavaScript.

    class :: ∀ msg. String -> Attribute msg
    class name =
      attribute "class" name

Read more about the difference between properties and attributes [here][].

[here]:: ∀ msg. https:: ∀ msg.//github.com/elm-lang/html/blob/master/properties-vs-attributes.md
-}
attribute :: ∀ msg. String -> String -> Attribute msg
attribute =
  VirtualDom.attribute


-- GLOBAL ATTRIBUTES


{-| Often used with CSS to style elements with common properties. -}
class_ :: ∀ msg. String -> Attribute msg
class_ name_ =
  stringProperty "className" name_


{-| Indicates the relevance of an element. -}
hidden :: ∀ msg. Boolean -> Attribute msg
hidden bool =
  boolProperty "hidden" bool


{-| Often used with CSS to style a specific element. The value of this
attribute must be unique.
-}
id :: ∀ msg. String -> Attribute msg
id name_ =
  stringProperty "id" name_


{-| Text to be displayed in a tooltip when hovering over the element. -}
title :: ∀ msg. String -> Attribute msg
title name_ =
  stringProperty "title" name_



-- LESS COMMON GLOBAL ATTRIBUTES

fromChar :: Char -> String
fromChar = show

{-| Defines a keyboard shortcut to activate or add focus to the element. -}
accesskey :: ∀ msg. Char -> Attribute msg
accesskey char =
  stringProperty "accessKey" (fromChar char)


{-| Indicates whether the element's content is editable. -}
contenteditable :: ∀ msg. Boolean -> Attribute msg
contenteditable bool =
  boolProperty "contentEditable" bool


{-| Defines the ID of a `menu` element which will serve as the element's
context menu.
-}
contextmenu :: ∀ msg. String -> Attribute msg
contextmenu v =
  attribute "contextmenu" v


{-| Defines the text direction. Allowed values are ltr (Left-To-Right) or rtl
(Right-To-Left).
-}
dir :: ∀ msg. String -> Attribute msg
dir v =
  stringProperty "dir" v


{-| Defines whether the element can be dragged. -}
draggable :: ∀ msg. String -> Attribute msg
draggable v =
  attribute "draggable" v


{-| Indicates that the element accept the dropping of content on it. -}
dropzone :: ∀ msg. String -> Attribute msg
dropzone v =
  stringProperty "dropzone" v


{-|-}
itemprop :: ∀ msg. String -> Attribute msg
itemprop v =
  attribute "itemprop" v


{-| Defines the language used in the element. -}
lang :: ∀ msg. String -> Attribute msg
lang v =
  stringProperty "lang" v


{-| Indicates whether spell checking is allowed for the element. -}
spellcheck :: ∀ msg. Boolean -> Attribute msg
spellcheck bool =
  boolProperty "spellcheck" bool


{-| Overrides the browser's default tab order and follows the one specified
instead.
-}
tabindex :: ∀ msg. Int -> Attribute msg
tabindex n =
  attribute "tabIndex" (show n)



-- HEADER STUFF


{-| Indicates that the `script` should be executed asynchronously. -}
async :: ∀ msg. Boolean -> Attribute msg
async bool =
  boolProperty "async" bool


{-| Declares the character encoding of the page or script. Common values include:: ∀ msg.

  * UTF-8 - Character encoding for Unicode
  * ISO-8859-1 - Character encoding for the Latin alphabet

For `meta` and `script`.
-}
charset :: ∀ msg. String -> Attribute msg
charset v =
  attribute "charset" v


{-| A value associated with http-equiv or name depending on the context. For
`meta`.
-}
content :: ∀ msg. String -> Attribute msg
content v =
  stringProperty "content" v


{-| Indicates that a `script` should be executed after the page has been
parsed.
-}
defer :: ∀ msg. Boolean -> Attribute msg
defer bool =
  boolProperty "defer" bool


{-| This attribute is an indicator that is paired with the `content` attribute,
indicating what that content means. `httpEquiv` can take on three different
values:: ∀ msg. content-type, default-style, or refresh. For `meta`.
-}
httpEquiv :: ∀ msg. String -> Attribute msg
httpEquiv v =
  stringProperty "httpEquiv" v


{-| Defines the script language used in a `script`. -}
language :: ∀ msg. String -> Attribute msg
language v =
  stringProperty "language" v


{-| Indicates that a `style` should only apply to its parent and all of the
parents children.
-}
scoped :: ∀ msg. Boolean -> Attribute msg
scoped bool =
  boolProperty "scoped" bool



-- EMBEDDED CONTENT


{-| The URL of the embeddable content. For `audio`, `embed`, `iframe`, `img`,
`input`, `script`, `source`, `track`, and `video`.
-}
src :: ∀ msg. String -> Attribute msg
src v =
  stringProperty "src" v


{-| Declare the height of a `canvas`, `embed`, `iframe`, `img`, `input`,
`object`, or `video`.
-}
height :: ∀ msg. Int -> Attribute msg
height v =
  attribute "height" (show v)


{-| Declare the width of a `canvas`, `embed`, `iframe`, `img`, `input`,
`object`, or `video`.
-}
width :: ∀ msg. Int -> Attribute msg
width v =
  attribute "width" (show v)


{-| Alternative text in case an image can't be displayed. Works with `img`,
`area`, and `input`.
-}
alt :: ∀ msg. String -> Attribute msg
alt v =
  stringProperty "alt" v



-- AUDIO and VIDEO


{-| The `audio` or `video` should play as soon as possible. -}
autoplay :: ∀ msg. Boolean -> Attribute msg
autoplay bool =
  boolProperty "autoplay" bool


{-| Indicates whether the browser should show playback controls for the `audio`
or `video`.
-}
controls :: ∀ msg. Boolean -> Attribute msg
controls bool =
  boolProperty "controls" bool


{-| Indicates whether the `audio` or `video` should start playing from the
start when it's finished.
-}
loop :: ∀ msg. Boolean -> Attribute msg
loop bool =
  boolProperty "loop" bool


{-| Control how much of an `audio` or `video` resource should be preloaded. -}
preload :: ∀ msg. String -> Attribute msg
preload v =
  stringProperty "preload" v


{-| A URL indicating a poster frame to show until the user plays or seeks the
`video`.
-}
poster :: ∀ msg. String -> Attribute msg
poster v =
  stringProperty "poster" v


{-| Indicates that the `track` should be enabled unless the user's preferences
indicate something different.
-}
default :: ∀ msg. Boolean -> Attribute msg
default bool =
  boolProperty "default" bool


{-| Specifies the kind of text `track`. -}
kind :: ∀ msg. String -> Attribute msg
kind v =
  stringProperty "kind" v


{-- TODO:: ∀ msg. maybe reintroduce once there's a better way to disambiguate imports
{-| Specifies a user-readable title of the text `track`. -}
label :: ∀ msg. String -> Attribute msg
label v =
  stringProperty "label" v
--}

{-| A two letter language code indicating the language of the `track` text data.
-}
srclang :: ∀ msg. String -> Attribute msg
srclang v =
  stringProperty "srclang" v



-- IFRAMES


{-| A space separated list of security restrictions you'd like to lift for an
`iframe`.
-}
sandbox :: ∀ msg. String -> Attribute msg
sandbox v =
  stringProperty "sandbox" v


{-|  Make an `iframe` look like part of the containing document. -}
seamless :: ∀ msg. Boolean -> Attribute msg
seamless bool =
  boolProperty "seamless" bool


{-| An HTML document that will be displayed as the body of an `iframe`. It will
override the content of the `src` attribute if it has been specified.
-}
srcdoc :: ∀ msg. String -> Attribute msg
srcdoc v =
  stringProperty "srcdoc" v



-- INPUT


{-| Defines the type of a `button`, `input`, `embed`, `object`, `script`,
`source`, `style`, or `menu`.
-}
type_ :: ∀ msg. String -> Attribute msg
type_ v =
  stringProperty "type" v


{-| Defines a default value which will be displayed in a `button`, `option`,
`input`, `li`, `meter`, `progress`, or `param`.
-}
value :: ∀ msg. String -> Attribute msg
value v =
  stringProperty "value" v


{-| Defines an initial value which will be displayed in an `input` when that
`input` is added to the DOM. Unlike `value`, altering `defaultValue` after the
`input` element has been added to the DOM has no effect.
-}
defaultValue :: ∀ msg. String -> Attribute msg
defaultValue v =
  stringProperty "defaultValue" v


{-| Indicates whether an `input` of type checkbox is checked. -}
checked :: ∀ msg. Boolean -> Attribute msg
checked bool =
  boolProperty "checked" bool


{-| Provides a hint to the user of what can be entered into an `input` or
`textarea`.
-}
placeholder :: ∀ msg. String -> Attribute msg
placeholder v =
  stringProperty "placeholder" v


{-| Defines which `option` will be selected on page load. -}
selected :: ∀ msg. Boolean -> Attribute msg
selected bool =
  boolProperty "selected" bool



-- INPUT HELPERS


{-| List of types the server accepts, typically a file type.
For `form` and `input`.
-}
accept :: ∀ msg. String -> Attribute msg
accept v =
  stringProperty "accept" v


{-| List of supported charsets in a `form`.
-}
acceptCharset :: ∀ msg. String -> Attribute msg
acceptCharset v =
  stringProperty "acceptCharset" v


{-| The URI of a program that processes the information submitted via a `form`.
-}
action :: ∀ msg. String -> Attribute msg
action v =
  stringProperty "action" v


{-| Indicates whether a `form` or an `input` can have their values automatically
completed by the browser.
-}
autocomplete :: ∀ msg. Boolean -> Attribute msg
autocomplete bool =
  stringProperty "autocomplete" (if bool then "on" else "off")


{-| The element should be automatically focused after the page loaded.
For `button`, `input`, `keygen`, `select`, and `textarea`.
-}
autofocus :: ∀ msg. Boolean -> Attribute msg
autofocus bool =
  boolProperty "autofocus" bool


{-| Indicates whether the user can interact with a `button`, `fieldset`,
`input`, `keygen`, `optgroup`, `option`, `select` or `textarea`.
-}
disabled :: ∀ msg. Boolean -> Attribute msg
disabled bool =
  boolProperty "disabled" bool


{-| How `form` data should be encoded when submitted with the POST method.
Options include:: ∀ msg. application/x-www-form-urlencoded, multipart/form-data, and
text/plain.
-}
enctype :: ∀ msg. String -> Attribute msg
enctype v =
  stringProperty "enctype" v


{-| Indicates the action of an `input` or `button`. This overrides the action
defined in the surrounding `form`.
-}
formaction :: ∀ msg. String -> Attribute msg
formaction v =
  attribute "formAction" v


{-| Associates an `input` with a `datalist` tag. The datalist gives some
pre-defined options to suggest to the user as they interact with an input.
The value of the list attribute must match the id of a `datalist` node.
For `input`.
-}
list :: ∀ msg. String -> Attribute msg
list v =
  attribute "list" v


{-| Defines the minimum number of characters allowed in an `input` or
`textarea`.
-}
minlength :: ∀ msg. Int -> Attribute msg
minlength n =
  attribute "minLength" (show n)


{-| Defines the maximum number of characters allowed in an `input` or
`textarea`.
-}
maxlength :: ∀ msg. Int -> Attribute msg
maxlength n =
  attribute "maxlength" (show n)


{-| Defines which HTTP method to use when submitting a `form`. Can be GET
(default) or POST.
-}
method :: ∀ msg. String -> Attribute msg
method v =
  stringProperty "method" v


{-| Indicates whether multiple values can be entered in an `input` of type
email or file. Can also indicate that you can `select` many options.
-}
multiple :: ∀ msg. Boolean -> Attribute msg
multiple bool =
  boolProperty "multiple" bool


{-| Name of the element. For example used by the server to identify the fields
in form submits. For `button`, `form`, `fieldset`, `iframe`, `input`, `keygen`,
`object`, `output`, `select`, `textarea`, `map`, `meta`, and `param`.
-}
name :: ∀ msg. String -> Attribute msg
name v =
  stringProperty "name" v


{-| This attribute indicates that a `form` shouldn't be validated when
submitted.
-}
novalidate :: ∀ msg. Boolean -> Attribute msg
novalidate bool =
  boolProperty "noValidate" bool


{-| Defines a regular expression which an `input`'s value will be validated
against.
-}
pattern :: ∀ msg. String -> Attribute msg
pattern v =
  stringProperty "pattern" v


{-| Indicates whether an `input` or `textarea` can be edited. -}
readonly :: ∀ msg. Boolean -> Attribute msg
readonly bool =
  boolProperty "readOnly" bool


{-| Indicates whether this element is required to fill out or not.
For `input`, `select`, and `textarea`.
-}
required :: ∀ msg. Boolean -> Attribute msg
required bool =
  boolProperty "required" bool


{-| For `input` specifies the width of an input in characters.

For `select` specifies the number of visible options in a drop-down list.
-}
size :: ∀ msg. Int -> Attribute msg
size n =
  attribute "size" (show n)


{-| The element ID described by this `label` or the element IDs that are used
for an `output`.
-}
for :: ∀ msg. String -> Attribute msg
for v =
  stringProperty "htmlFor" v


{-| Indicates the element ID of the `form` that owns this particular `button`,
`fieldset`, `input`, `keygen`, `label`, `meter`, `object`, `output`,
`progress`, `select`, or `textarea`.
-}
form :: ∀ msg. String -> Attribute msg
form v =
  attribute "form" v



-- RANGES


{-| Indicates the maximum value allowed. When using an input of type number or
date, the max value must be a number or date. For `input`, `meter`, and `progress`.
-}
max :: ∀ msg. String -> Attribute msg
max v =
  stringProperty "max" v


{-| Indicates the minimum value allowed. When using an input of type number or
date, the min value must be a number or date. For `input` and `meter`.
-}
min :: ∀ msg. String -> Attribute msg
min v =
  stringProperty "min" v


{-| Add a step size to an `input`. Use `step "any"` to allow any floating-point
number to be used in the input.
-}
step :: ∀ msg. String -> Attribute msg
step n =
  stringProperty "step" n


--------------------------


{-| Defines the number of columns in a `textarea`. -}
cols :: ∀ msg. Int -> Attribute msg
cols n =
  attribute "cols" (show n)


{-| Defines the number of rows in a `textarea`. -}
rows :: ∀ msg. Int -> Attribute msg
rows n =
  attribute "rows" (show n)


{-| Indicates whether the text should be wrapped in a `textarea`. Possible
values are "hard" and "soft".
-}
wrap :: ∀ msg. String -> Attribute msg
wrap v =
  stringProperty "wrap" v



-- MAPS


{-| When an `img` is a descendent of an `a` tag, the `ismap` attribute
indicates that the click location should be added to the parent `a`'s href as
a query string.
-}
ismap :: ∀ msg. Boolean -> Attribute msg
ismap v =
  boolProperty "isMap" v


{-| Specify the hash name reference of a `map` that should be used for an `img`
or `object`. A hash name reference is a hash symbol followed by the element's name or id.
E.g. `"#planet-map"`.
-}
usemap :: ∀ msg. String -> Attribute msg
usemap v =
  stringProperty "useMap" v


{-| Declare the shape of the clickable area in an `a` or `area`. Valid values
include:: ∀ msg. default, rect, circle, poly. This attribute can be paired with
`coords` to create more particular shapes.
-}
shape :: ∀ msg. String -> Attribute msg
shape v =
  stringProperty "shape" v


{-| A set of values specifying the coordinates of the hot-spot region in an
`area`. Needs to be paired with a `shape` attribute to be meaningful.
-}
coords :: ∀ msg. String -> Attribute msg
coords v =
  stringProperty "coords" v



-- KEY GEN


{-| A challenge string that is submitted along with the public key in a `keygen`.
-}
challenge :: ∀ msg. String -> Attribute msg
challenge v =
  attribute "challenge" v


{-| Specifies the type of key generated by a `keygen`. Possible values are:: ∀ msg.
rsa, dsa, and ec.
-}
keytype :: ∀ msg. String -> Attribute msg
keytype v =
  stringProperty "keytype" v



-- REAL STUFF


{-| Specifies the horizontal alignment of a `caption`, `col`, `colgroup`,
`hr`, `iframe`, `img`, `table`, `tbody`,  `td`,  `tfoot`, `th`, `thead`, or
`tr`.
-}
align :: ∀ msg. String -> Attribute msg
align v =
  stringProperty "align" v


{-| Contains a URI which points to the source of the quote or change in a
`blockquote`, `del`, `ins`, or `q`.
-}
cite :: ∀ msg. String -> Attribute msg
cite v =
  stringProperty "cite" v




-- LINKS AND AREAS


{-| The URL of a linked resource, such as `a`, `area`, `base`, or `link`. -}
href :: ∀ msg. String -> Attribute msg
href v =
  stringProperty "href" v


{-| Specify where the results of clicking an `a`, `area`, `base`, or `form`
should appear. Possible special values include:: ∀ msg.

  * _blank &mdash; a new window or tab
  * _self &mdash; the same frame (this is default)
  * _parent &mdash; the parent frame
  * _top &mdash; the full body of the window

You can also give the name of any `frame` you have created.
-}
target :: ∀ msg. String -> Attribute msg
target v =
  stringProperty "target" v


{-| Indicates that clicking an `a` and `area` will download the resource
directly.
-}
download :: ∀ msg. Boolean -> Attribute msg
download bool =
  boolProperty "download" bool


{-| Indicates that clicking an `a` and `area` will download the resource
directly, and that the downloaded resource with have the given filename.
-}
downloadAs :: ∀ msg. String -> Attribute msg
downloadAs v =
  stringProperty "download" v


{-| Two-letter language code of the linked resource of an `a`, `area`, or `link`.
-}
hreflang :: ∀ msg. String -> Attribute msg
hreflang v =
  stringProperty "hreflang" v


{-| Specifies a hint of the target media of a `a`, `area`, `link`, `source`,
or `style`.
-}
media :: ∀ msg. String -> Attribute msg
media v =
  attribute "media" v


{-| Specify a URL to send a short POST request to when the user clicks on an
`a` or `area`. Useful for monitoring and tracking.
-}
ping :: ∀ msg. String -> Attribute msg
ping v =
  stringProperty "ping" v


{-| Specifies the relationship of the target object to the link object.
For `a`, `area`, `link`.
-}
rel :: ∀ msg. String -> Attribute msg
rel v =
  attribute "rel" v



-- CRAZY STUFF


{-| Indicates the date and time associated with the element.
For `del`, `ins`, `time`.
-}
datetime :: ∀ msg. String -> Attribute msg
datetime v =
  attribute "datetime" v


{-| Indicates whether this date and time is the date of the nearest `article`
ancestor element. For `time`.
-}
pubdate :: ∀ msg. String -> Attribute msg
pubdate v =
  attribute "pubdate" v



-- ORDERED LISTS


{-| Indicates whether an ordered list `ol` should be displayed in a descending
order instead of a ascending.
-}
reversed :: ∀ msg. Boolean -> Attribute msg
reversed bool =
  boolProperty "reversed" bool


{-| Defines the first number of an ordered list if you want it to be something
besides 1.
-}
start :: ∀ msg. Int -> Attribute msg
start n =
  stringProperty "start" (show n)



-- TABLES


{-| The colspan attribute defines the number of columns a cell should span.
For `td` and `th`.
-}
colspan :: ∀ msg. Int -> Attribute msg
colspan n =
  attribute "colspan" (show n)


{-| A space separated list of element IDs indicating which `th` elements are
headers for this cell. For `td` and `th`.
-}
headers :: ∀ msg. String -> Attribute msg
headers v =
  stringProperty "headers" v


{-| Defines the number of rows a table cell should span over.
For `td` and `th`.
-}
rowspan :: ∀ msg. Int -> Attribute msg
rowspan n =
  attribute "rowspan" (show n)


{-| Specifies the scope of a header cell `th`. Possible values are:: ∀ msg. col, row,
colgroup, rowgroup.
-}
scope :: ∀ msg. String -> Attribute msg
scope v =
  stringProperty "scope" v


{-| Specifies the URL of the cache manifest for an `html` tag. -}
manifest :: ∀ msg. String -> Attribute msg
manifest v =
  attribute "manifest" v


{-- TODO:: ∀ msg. maybe reintroduce once there's a better way to disambiguate imports
{-| The number of columns a `col` or `colgroup` should span. -}
span :: ∀ msg. Int -> Attribute msg
span n =
    stringProperty "span" (show n)
--}