Some functions create Nodes. The `Html` type is an alias for the `Node` type


```  
-- HtmlElement: HTML element where we will insert our view
-- (Model -> Html msg): View function
-- Stepper
normalRenderer :: HtmlElement -> (Model -> Html msg) -> Stepper

-- EffectfulMessageReceiver: Function to take a message and pass it to our program
-- Model: An initial model to start the view
-- UpdateView
type alias Stepper = EffectfullMessageReceiver -> Model -> UpdateView

-- Model: A new model to be rendered
-- IO (): This just means that this function will update our view
type alias UpdateView = Model -> IO ()

```

Renderer -> Stepper

The stepper updates the view. It takes a model and updates the view.