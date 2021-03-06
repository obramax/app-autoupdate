defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ServerWeb do
    pipe_through :browser

    get "/", PageController, :index

    post "/", PageController, :upload

    get "/download/:file", PageController, :download
  end

  scope "/api", ServerWeb do
    pipe_through :api

    get "/files", FileController, :index
  end
end
