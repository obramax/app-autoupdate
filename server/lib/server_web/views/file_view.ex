defmodule ServerWeb.FileView do
  use ServerWeb, :view
  alias ServerWeb.FileView

  def render("index.json", %{files: files}) do
    %{data: render_many(files, FileView, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{
      name: file.name,
      url: file.url
    }
  end
end
