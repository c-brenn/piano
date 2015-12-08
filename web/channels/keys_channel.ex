defmodule Keyboard.KeysChannel do
  use Phoenix.Channel

  def join("keys:join", _message, socket) do
    {:ok, socket}
  end

  def handle_in("key_press", %{"body" => body}, socket) do
    broadcast! socket, "key_press", %{body: body}
    {:noreply, socket}
  end
end
