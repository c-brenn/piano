module KeyBoard where

import Key
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [incomingActions]
    }

main : Signal Html
main =
  app.html

port tasks : Signal (Task Never ())
port tasks =
   app.tasks

-- Model

type alias Model =
  List (ID, Key.Model)

type alias ID = String

init : (Model, Effects Action)
init =
    let keys = List.map initKey playableKeys
    in
        (keys, Effects.none)

initKey : (String, String, String) -> (ID, Key.Model)
initKey (id, colour, text) =
    (id, Key.init (colour, text))

playableKeys =
  [
    ("C:4"  , "white", "a"),
    ("C#:4" , "black", "w"),
    ("D:4"  , "white", "s"),
    ("D#:4" , "black", "e"),
    ("E:4"  , "white", "d"),
    ("F:4"  , "white", "f"),
    ("F#:4" , "black", "t"),
    ("G:4"  , "white", "g"),
    ("G#:4" , "black", "y"),
    ("A:4"  , "white", "h"),
    ("A#:4" , "black", "u"),
    ("B:4"  , "white", "j"),
    ("C:5"  , "white", "k"),
    ("C#:5" , "black", "o"),
    ("D:5"  , "white", "l"),
    ("D#:5" , "black", "p"),
    ("E:5"  , "white", ";"),
    ("F:5"  , "white", "'")
    ]

-- Update

type Action
  = Event ID Key.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Event id keyAction ->
      let updateKey (keyId, keyModel) =
            if keyId == id then
              (keyId, Key.update keyAction keyModel)
            else
              (keyId, keyModel)
      in
        (List.map updateKey model, Effects.none)

-- View
view : Signal.Address Action -> Model -> Html
view address model =
  ul
  [ class "keys" ]
  (List.map (viewKey address) model)

viewKey : Signal.Address Action -> (ID, Key.Model) -> Html
viewKey address (id, model) =
  Key.view (Signal.forwardTo address (Event id)) model id

-- SIGNALS
port keyPresses  : Signal String
port keyReleases : Signal String

incomingActions : Signal Action
incomingActions =
    let presses  = Signal.map (\keyId -> Event keyId Key.Press) keyPresses
        releases = Signal.map (\keyId -> Event keyId Key.Release) keyReleases
    in
        Signal.merge presses releases
