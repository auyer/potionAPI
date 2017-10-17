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

	scope "/api", ServerAPI do
	 pipe_through :api

	 get "/list", FileController, :list
	 post "/new", FileController, :create
	 get "/file/:id", FileController, :show
	 post "/file/:id", FileController, :update
	 delete "/file/:id", FileController, :delete
	end
end
