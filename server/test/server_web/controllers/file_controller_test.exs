defmodule ServerWeb.FileControllerTest do
  use ServerWeb.ConnCase

  alias ServerWeb.PageController

  test "GET /api/files when listing files", %{conn: conn} do
    File.copy!(Path.join([File.cwd!(), "test", "fixtures", "dummy.txt"]), Path.join([PageController.get_path(), "dummy.txt"]))

    conn = get(conn, Routes.file_path(conn, :index))

    assert json_response(conn, 200) == %{
      "data" => [
        %{
          "name" => "dummy.txt",
          "url" => "/download/dummy.txt"
        }
      ]
    }
  end

end
