defmodule Keyboard.PageControllerTest do
  use Keyboard.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "<h2>play the keyboard with the internet</h2>"
  end
end
