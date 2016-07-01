defmodule MyApp.HealthControllerTest do
  use MyApp.ConnCase, async: true

  test "GET /api/health" do
    conn = conn() |> get("/api/health")
    assert json_response(conn, 200) == %{"OK" => true}
  end
end
