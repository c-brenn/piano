defmodule Keyboard.Songs do
  def get_notes(song) do
    case song do
      :titanic -> titanic
      :leekspin -> leekspin
      _ -> []
    end
  end

  defp titanic do
    [
      {"E:4", factor(1.5)},
      {"E:4", factor(2 / 3)},
      {"E:4", beat},
      {"E:4", beat},
      {"D#:4", beat},
      {"E:4", factor(2)},
      {"D#:4", beat},
      {"D#:4", beat},
      {"E:4", factor(2)},
      {"F#:4", beat},
      {"G#:4", factor(2)},
      {"F#:4", factor(2)},
      {"E:4", factor(1.5)},
      {"E:4", factor(2 / 3)},
      {"E:4", beat},
      {"E:4", beat},
      {"D#:4", beat},
      {"E:4", factor(2)},
      {"D#:4", beat},
      {"C#:4", factor(4)},
      {"E:4", factor(2)},
      {"F#:4", factor(2)},
      {"B:4", factor(1.5)},
      {"B:4", factor(1.25)},
      {"A:4", beat},
      {"G#:4", beat},
      {"F#:4", factor(1.5)},
      {"G#:4", beat},
      {"A:4", beat},
      {"G#:4", factor(1.5)},
      {"F#:4", beat},
      {"E:4", beat},
      {"D#:4", beat},
      {"E:4", factor(1.5)},
      {"D#:4", beat},
      {"D#:4", beat},
      {"E:4", factor(1.5)},
      {"F#:4", beat},
      {"G#:4", factor(2.5)},
      {"F#:4", factor(2.5)},
      {"E:4", factor(1.5)}
    ]
  end

  defp leekspin do
    [
      {"D:4", beat},
      {"D:4", beat},
      {"D:4", factor(1.5)},
      {"E:4", factor(0.5)},
      {"F:4", beat},
      {"D:4", beat},
      {"D:4", factor(1.5)},
      {"F:4", factor(0.5)},
      {"E:4", beat},
      {"C:4", beat},
      {"C:4", factor(1.5)},
      {"E:4", factor(0.5)},
      {"F:4", beat},
      {"D:4", beat},
      {"D:4", factor(2)},
      {"D:4", beat},
      {"D:4", beat},
      {"D:4", factor(1.5)},
      {"E:4", factor(0.5)},
      {"F:4", beat},
      {"D:4", beat},
      {"D:4", beat},
      {"F:4", beat},
      {"A:4", factor(0.5)},
      {"A:4", factor(0.5)},
      {"A:4", factor(0.5)},
      {"G:4", factor(0.5)},
      {"F:4", beat},
      {"E:4", beat},
      {"F:4", beat},
      {"D:4", beat},
      {"D:4", beat},
      {"F:4", beat},
      {"A:4", factor(0.5)},
      {"A:4", factor(0.5)},
      {"A:4", factor(0.5)},
      {"A:4", factor(0.5)},
      {"G:4", beat},
      {"F:4", beat},
      {"E:4", beat},
      {"C:4", beat},
      {"C:4", beat},
      {"E:4", beat},
      {"G:4", factor(0.5)},
      {"G:4", factor(0.5)},
      {"G:4", factor(0.5)},
      {"G:4", factor(0.5)},
      {"F:4", beat},
      {"E:4", beat},
      {"F:4", beat},
      {"D:4", beat},
      {"D:4", beat}
    ]
  end

  defp beat do
    350
  end

  defp factor(fac) do
    round(beat * fac)
  end
end
