defmodule ServerAPI.Songs do
	use ServerAPI.Web, :model
		
	def changeset(model, params \\ :empty) do
		model
			|> cast(params, [:name, :artist, :url, :genre])
			|> unique_constraint(:id)
	end
	schema "Songs" do
		field :name, :string
		field :artist, :string
		field :url,  :string
		field :genre, :string
	end
end
