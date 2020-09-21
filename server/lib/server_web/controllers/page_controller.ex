defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  @upload_folder Application.get_env(:server, :upload_folder)

  def index(conn, _params) do
    {:ok, files} = get_files()

    render(conn, "index.html", files: files)
  end

  def upload(conn, %{"file" => %{path: path, filename: filename}}) do
    case File.copy(path, Path.join([get_path(), filename])) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Uploaded successfully!")
        |> redirect(to: Routes.page_path(conn, :index))

      error ->
        error
    end
  end

  def download(conn, %{"file" => file}) do
    send_download(conn, {:file, Path.join([get_path(), file])})
  end

  def get_files() do
    path = get_path()

    case File.mkdir_p(path) do
      :ok ->
        File.ls(path)

      {:error, :eexist} ->
        File.ls(path)

      error ->
        error
    end
  end

  def get_path() do
    Path.join([@upload_folder, "uploaded"])
  end
end
