defmodule EliteInvestigationsWeb.Router do
  use EliteInvestigationsWeb, :router

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

  scope "/", EliteInvestigationsWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/galnet/search", StoryController, :search
    resources "/galnet", StoryController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", EliteInvestigationsWeb do
  #   pipe_through :api
  # end
end
