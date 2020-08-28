defmodule ServerWeb.FileController do
  use ServerWeb, :controller

  def index(conn, _params) do
    {:ok, files} = ServerWeb.PageController.get_files()

    response =
      Enum.map(
        files,
        &%{
          name: &1,
          url: Routes.page_path(conn, :download, &1)
        }
      )

    render(conn, "index.json", files: response)
  end
end
