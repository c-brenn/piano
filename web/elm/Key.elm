module Key where

import Html exposing (..)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)

-- Model

type Colour
  = White
  | Black

type State
  = Pressed
  | Released

type alias Model =
  { colour : Colour
  , state : State
  , text : String
  }

init : (String, String) -> Model
init (colour, text) =
    { colour = parseColour colour
    , state = Released
    , text = text
    }

parseColour : String -> Colour
parseColour str =
  case str of
    "white" ->
      White
    _ ->
      Black

-- Update

type Action
  = Press
  | Release

update : Action -> Model -> Model
update action model =
  case action of
    Press ->
      { model | state = Pressed }
    Release ->
      { model | state = Released }

-- View

view : Signal.Address Action -> Model -> String -> Html
view address model keyId =
  div
    [ keyClass model
    , onClick address Press
    , id keyId
    ]
    [ text model.text ]

keyClass : Model -> Attribute
keyClass model =
  class ("note " ++ (keyColour model.colour) ++ " " ++ keyState model.state)

keyColour : Colour -> String
keyColour colour =
  case colour of
    White ->
      "white"
    Black ->
      "black"

keyState : State -> String
keyState state =
  case state of
    Released ->
      ""
    Pressed ->
      "animated pulse"
