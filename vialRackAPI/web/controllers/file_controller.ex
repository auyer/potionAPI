defmodule VialRackAPI.FileController do
  use VialRackAPI.Web, :controller

  defp conn_with_status(conn, nil) do
    conn
      |> put_status(:not_found)
  end
  defp conn_with_status(conn, _) do
    conn
      |> put_status(:ok)
  end


  def list(conn, _params) do
    files = Repo.all(VialRackAPI.File)
    json conn_with_status(conn, files), files
  end

  def show(conn, %{"id" => id}) do
    files = Repo.get(VialRackAPI.File, String.to_integer(id))
    json conn_with_status(conn, files), files
  end

  @doc """
  Recieves connection and a JSON with the parameter, pass the encoded file to the StoreFile module, and adds the data to the database.

  ## Examples

      iex> create( conn, JSON_parameters)

            Expected output  {conn, JSON}
            Error output     {conn_with_status, reason}

  """
  def create(conn, params) do
    case Map.fetch(params, "file") do
      {:ok, file} ->
        case VialRackAPI.StoreFile.upload(file, Map.fetch(params, "ext")) do
          {:ok, url} ->
            changeset = VialRackAPI.File.changeset(%VialRackAPI.File{}, Map.replace(params, "file", url))
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

  @doc """
  Recieves connection with a ID, and a JSON with the new parameters parameter.

  ## Examples

      iex> create( conn, JSON_parameters)

            Expected output  {conn, JSON}
            Error output     {conn_with_status, reason}

  """
  def update(conn, %{"id" => id} = params) do
    file = Repo.get(VialRackAPI.File, id)
    if file do
      perform_update(conn, file, params)
    else
      json conn |> put_status(:bad_request),
                   %{errors: ["invalid file"]}
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:get, file} when not is_nil(file) <- {:get, Repo.get(VialRackAPI.File, id)},
         {:repo_delete, {:ok, _}} <- {:repo_delete, Repo.delete(file)},
         {:disc_delete, :ok} <- {:disc_delete, VialRackAPI.StoreFile.delete(file)} do
      json conn |> put_status(204), nil
    else
      {:get, nil} -> json conn |> put_status(:bad_request), %{errors: ["File not Found"]}
      {:repo_delete, _} -> json conn |> put_status(:bad_request), %{errors: ["Unable to Delete File"]}
      {:disc_delete, _} -> json conn |> put_status(:bad_request), %{errors: ["Unable to Delete File"]}
    end
  end


 defp perform_update(conn, file, params) do
    changeset = VialRackAPI.File.changeset(file, params)
    case Repo.update(changeset) do
      {:ok, file} ->
        json conn |> put_status(:ok), file
      {:error, _result} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to update file"]}
    end
  end
end
