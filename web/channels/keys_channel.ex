defmodule Keyboard.KeysChannel do
  alias Keyboard.Tunes
  use Phoenix.Channel

  def join("keys:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("playing?", %{}, socket) do
    push socket, "playing", %{song: Tunes.playing}
    {:noreply, socket}
  end

  def handle_in("key_press", %{"body" => body}, socket) do
    broadcast! socket, "key_press", %{body: body}
    {:noreply, socket}
  end

  def handle_in("titanic", %{}, socket) do
    Tunes.play(:titanic)
    {:noreply, socket}
  end

  def handle_in("leekspin", %{}, socket) do
    Tunes.play(:leekspin)
    {:noreply, socket}
  end
end
