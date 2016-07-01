defmodule MyApp.HealthController do
  use MyApp.Web, :controller

  def show(conn, _params) do
    json conn, %{OK: true}
  end
end
