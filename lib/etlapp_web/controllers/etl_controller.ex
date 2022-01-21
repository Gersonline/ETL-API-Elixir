defmodule EtlappWeb.EtlController do
  use EtlappWeb, :controller

  alias Etlapp.Load

  def index(conn, _params) do
    "ok"
    |>Load.create()
    |>handle_response(conn)

  end

  defp handle_response({:ok, load}, conn) do
    conn
    |> put_status(:ok)
    |> render("create.json", load: load)
  end

  defp handle_response({:error, message}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: message})
  end
end
