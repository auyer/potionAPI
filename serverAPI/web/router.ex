defmodule ServerAPI.Router do
  use ServerAPI.Web, :router

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

  #scope "/", ServerAPI do
  #  pipe_through :browser # Use the default browser stack

  #  get "/", PageController, :index
  #end

   scope "/api", ServerAPI do
     pipe_through :api
   
     get "/songs", SongsController, :index
     get "/song/:id", SongsController, :show
     post "/song", SongsController, :create
     put "/song/:id", SongsController, :update
   end
end
