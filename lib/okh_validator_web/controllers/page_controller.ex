defmodule OkhValidatorWeb.PageController do
  use OkhValidatorWeb, :controller

  def index(conn, _params) do
    manifest = "test"
    render(conn, "index.html", manifest: manifest)
  end
end
