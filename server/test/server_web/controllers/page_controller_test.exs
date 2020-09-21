defmodule ServerWeb.PageControllerTest do
  use ServerWeb.ConnCase

  alias ServerWeb.PageController

  setup do
    {:ok, _} = File.rm_rf(PageController.get_path())

    File.mkdir_p(PageController.get_path())
  end

  test "GET / when no files were uploaded", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "No files uploaded."
  end

  test "GET / when there are files uploaded", %{conn: conn} do
    File.copy!(Path.join([File.cwd!(), "test", "fixtures", "dummy.txt"]), Path.join([PageController.get_path(), "dummy.txt"]))

    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "dummy.txt"
  end

  test "POST / when uploading file", %{conn: conn} do
    conn = post(conn, Routes.page_path(conn, :upload), %{
      "file" => %Plug.Upload{
        path: Path.join([File.cwd!(), "test", "fixtures", "dummy.txt"]),
        filename: "dummy.txt"
      }
    })

    assert redirected_to(conn, 302) == Routes.page_path(conn, :index)

    assert get_flash(conn) == %{
      "info" => "Uploaded successfully!"
    }
  end

  test "get /download/:file when downloading a file", %{conn: conn} do
    File.copy!(Path.join([File.cwd!(), "test", "fixtures", "dummy.txt"]), Path.join([PageController.get_path(), "dummy.txt"]))

    conn = get(conn, Routes.page_path(conn, :download, "dummy.txt"))

    assert text_response(conn, 200) == "content"
  end

end
