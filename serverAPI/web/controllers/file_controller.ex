defmodule ServerAPI.FileController do
  use ServerAPI.Web, :controller

  defp conn_with_status(conn, nil) do
    conn
      |> put_status(:not_found)
  end
  defp conn_with_status(conn, _) do
    conn
      |> put_status(:ok)
  end


  def index(conn, _params) do
    files = Repo.all(ServerAPI.File)
    json conn_with_status(conn, files), files
  end

  def show(conn, %{"id" => id}) do
    files = Repo.get(ServerAPI.File, String.to_integer(id))
    json conn_with_status(conn, files), files
  end
  """
  def create(conn, params) do
    changeset = ServerAPI.File.changeset(%ServerAPI.File{}, params)
  case Repo.insert(changeset) do
    {:ok, file} ->
        IO.inspect(params)
	     json conn |> put_status(:created), file
    {:error, _changeset} ->
	     json conn |> put_status(:bas_request), %{errors: ["Unable to add File"]}
	  end
  end
  """
  def create(conn, params) do
    case Map.fetch(params, "file") do
      {:ok, file} ->
        case ServerAPI.StoreFile.upload(file, Map.fetch(params, "ext")) do
          {:ok, url} ->
            changeset = ServerAPI.File.changeset(%ServerAPI.File{}, Map.replace(params, "file", url))
            case Repo.insert(changeset) do
              {:ok, file} ->
                 json conn |> put_status(:created), file
              {:error, _changeset} ->
                 json conn |> put_status(:bad_request), %{errors: ["Unable to add to Database"]}
            end
          {:error, reason} ->
             json conn |> put_status(:bad_request), %{errors: [reason]}
        end
      :error ->
        json conn |> put_status(:bad_request), %{errors: ["Unable to read File"]}
    end
  end

 def update(conn, %{"id" => id} = params) do
    file = Repo.get(ServerAPI.File, id)
    if file do
      perform_update(conn, file, params)
    else
      json conn |> put_status(:not_found),
                   %{errors: ["invalid file"]}
    end
  end

  def delete(conn, %{"id" => id} = params) do
    case Map.fetch(params, "file") do
      {:ok, file} ->
        #ServerAPI.StoreFile.deleteFile(file)
        Repo.get!(ServerAPI.File, id)
          |> Repo.delete!
        json conn_with_status(conn, :ok), :ok
      _ ->
        json conn |> put_status(:not_found),
                     %{errors: ["invalid file"]}
    end
  end


 defp perform_update(conn, file, params) do
    changeset = ServerAPI.File.changeset(file, params)
    case Repo.update(changeset) do
      {:ok, file} ->
        json conn |> put_status(:ok), file
      {:error, _result} ->
        json conn |> put_status(:bad_request),
                     %{errors: ["unable to update file"]}
    end
  end
end
