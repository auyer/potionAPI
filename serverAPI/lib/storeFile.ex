defmodule ServerAPI.StoreFile do

  @moduledoc """
  Responsible for accepting files and uploading them to an asset store.
  """

  @doc """
  Accepts a base64 encoded image and saves it

  ## Examples

      iex> upload_image( data_encoded, file_extension)


  """

  def upload(base64,ext) do
    # Decode the image
    case Base.decode64(base64) do
    {:ok, binary} ->
      filename = unique_filename(ext)
      IO.inspect(binary)
      case File.write!("priv/static/files/" <> filename, binary) do
        :ok -> {:ok, "/files/" <> filename}
        {:error, reason}-> {:error, reason}
      end
    {:error} -> {:error,"Error Converting from Base 64"}
    end
  end


  # Generates a unique filename with a given extension
  defp unique_filename(ext) do
    case ext do
      {:ok, extension}->
        UUID.uuid4(:hex) <> "." <> extension
      _ ->
        {:error}
    end
  end



end
