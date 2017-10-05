defmodule ServerAPI.File do
	use ServerAPI.Web, :model

	def changeset(model, params \\ :empty) do
		model
			|> cast(params, [:file, :metadata, :ext])
			|> unique_constraint(:id)
	end

#	def getID(model)
#		import Ecto.Query
#		file = ServerAPI.File.undeleted(
#		)

	@derive {Poison.Encoder, only: [:id, :file, :metadata, :ext]}
	schema "File" do
		field :file, :string
		field :metadata, :map
		field :ext, :string

		timestamps()
	end
end
