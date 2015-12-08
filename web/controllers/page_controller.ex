defmodule Keyboard.PageController do
  use Keyboard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
