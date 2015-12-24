module KeyBoard where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Html exposing (..)
import Html.Attributes exposing (class, id)
import Html.Events exposing(onClick)

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
-- MODEL

type Colour = Black | White
type State = Pressed | Released

type alias Key =
  { note : String
  , colour : Colour
  , state : State
  , text  : String
  }

initKey : (String, Colour, String) -> Key
initKey (n, c, t)=
    { note = n
    , colour = c
    , state = Released
    , text = t
    }

type alias Model =
  List Key

init : (Model, Effects Action)
init =
    let keys = List.map initKey playableKeys
    in (keys, Effects.none)

playableKeys =
  [
    ("C:4"  , White, "a"),
    ("C#:4" , Black, "w"),
    ("D:4"  , White, "s"),
    ("D#:4" , Black, "e"),
    ("E:4"  , White, "d"),
    ("F:4"  , White, "f"),
    ("F#:4" , Black, "t"),
    ("G:4"  , White, "g"),
    ("G#:4" , Black, "y"),
    ("A:4"  , White, "h"),
    ("A#:4" , Black, "u"),
    ("B:4"  , White, "j"),
    ("C:5"  , White, "k"),
    ("C#:5" , Black, "o"),
    ("D:5"  , White, "l"),
    ("D#:5" , Black, "p"),
    ("E:5"  , White, ";"),
    ("F:5"  , White, "'")
    ]

-- UPDATE
type Action = Press String

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Press keyToPress ->
      let
          updateKey keyFromModel =
            if keyToPress == keyFromModel.note then
              { keyFromModel | state = Pressed }
            else { keyFromModel | state = Released }
      in (List.map updateKey model, Effects.none)

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  ul [ class "keys" ] (List.map (keyView address) model)

keyView : Signal.Address Action -> Key -> Html
keyView address key =
  li [class ("note " ++ (keyClass key)), id (key.note), onClick address (Press key.note)] [text key.text]

keyClass : Key -> String
keyClass { note, colour, state} = (keyColour colour) ++ " "++ stateClass state

keyColour : Colour -> String
keyColour colour =
  case colour of
    White -> "white"
    Black -> "black"

stateClass : State -> String
stateClass state =
  case state of
    Released -> ""
    Pressed -> "animated pulse"

-- SIGNALS
port keyEvents : Signal String

incomingActions : Signal Action
incomingActions =
    Signal.map Press keyEvents
