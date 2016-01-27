defmodule Keyboard.Tunes do
  alias Keyboard.{Endpoint, Songs}
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, :nothing}
  end

  def play(song) do
    GenServer.cast(__MODULE__, {:play, song})
  end

  def playing do
    GenServer.call(__MODULE__, :playing)
  end

  def handle_call(:playing, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:play, song}, :nothing) do
    send(self, {:play_note, Songs.get_notes(song)})
    Endpoint.broadcast! "keys:lobby", "playing", %{song: song}
    {:noreply, song}
  end
  def handle_cast({:play, _song}, currently_playing) do
    {:noreply, currently_playing}
  end

  def handle_info({:play_note, []}, song) do
    Endpoint.broadcast! "keys:lobby", "finished", %{song: song}
    {:noreply, :nothing}
  end
  def handle_info({:play_note, [{note, delay}|rest]}, song) do
    Endpoint.broadcast! "keys:lobby", "key_press", %{body: note}
    Process.send_after(self, {:play_note, rest}, delay)
    {:noreply, song}
  end
  def handle_info(_, state), do: state
end
