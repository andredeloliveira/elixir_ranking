defmodule RankingWeb.Router do
  use RankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug RankingWeb.Plug.AuthAccessPipeline
  end

  scope "/api", RankingWeb do
    pipe_through :api

    scope "/auth" do
      post "/identity/callback", AuthenticationController, :identity_callback
    end

    pipe_through :authenticated
    resources "/users", UserController, except: [:new, :edit]
    
  end

end
