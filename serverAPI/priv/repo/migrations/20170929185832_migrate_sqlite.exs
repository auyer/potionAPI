defmodule ServerAPI.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:file) do
      add :file, :string
      add :metadata, :map
      add :ext, :string

      timestamps()

    end
  end
end
