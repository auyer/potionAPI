 defmodule ServerAPI.Repo.Migrations.Create_Songs do
    use Ecto.Migration
 
   def change do
         create table(:Songs) do
                 add :name, :string
                 add :artist, :string
                 add :url,  :string
                 add :genre, :string
         end
         create unique_index(:Songs, [:id])
   end
  end
