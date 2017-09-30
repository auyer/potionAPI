defmodule ServerAPI.File do
	use ServerAPI.Web, :model

	def changeset(model, params \\ :empty) do
		model
			|> cast(params, [:file, :metadata, :ext])
			|> unique_constraint(:id)
	end

	@derive {Poison.Encoder, only: [:file, :metadata, :ext]}
	schema "File" do
		field :file, :string
		field :metadata, :map
		field :ext, :string

		timestamps()
	end
end
