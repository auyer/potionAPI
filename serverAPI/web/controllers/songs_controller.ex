defmodule ServerAPI.SongsController do
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
    songs = Repo.all(ServerAPI.Songs)
    json conn_with_status(conn, songs), songs
  end
  
  def show(conn, %{"id" => id}) do
    songs = Repo.get(ServerAPI.Songs, String.to_integer(id))
    json conn_with_status(conn, songs), songs
  end  
  def create(conn, params) do
    changeset = ServerAPI.Songs.changeset(%ServerAPI.Songs{}, params)
  case Repo.insert(changeset) do
    {:ok, song} ->
	json conn |> put_status(:created), song
    {:error, _changeset} ->
	json conn |> put_status(:bas_request), %{errors: ["Unable to add Song"]}
	end
  end
 def update(conn, %{"id" => id} = params) do
    song = Repo.get(ServerAPI.Songs, id)
    if song do
      perform_update(conn, song, params)
    else
      json conn |> put_status(:not_found), 
                   %{errors: ["invalid song"]}
    end
  end

 defp perform_update(conn, song, params) do
    changeset = ServerAPI.Songs.changeset(song, params)
    case Repo.update(changeset) do
      {:ok, song} ->
        json conn |> put_status(:ok), song
      {:error, _result} ->
        json conn |> put_status(:bad_request),
                     %{errors: ["unable to update song"]}
    end
  end
end
