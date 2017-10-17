defmodule ServerAPI.StoreFile do

	@moduledoc """
	Responsible for managing files (Uploading and deletion).
	"""

	@doc """
	Accepts a base64 encoded image and saves it with a generated name and the provided extension.

	## Examples

			iex> upload( 64b_encoded_data, file_extension)

						Expected output  {:ok, url}
						Error output     {:error, reason}

	"""

	def upload(base64,ext) do
		# Decode the image
		case Base.decode64(base64) do
		{:ok, binary} ->
			filename = unique_filename(ext)
			case File.write("priv/static/files/" <> filename, binary) do
				:ok -> {:ok, "/static/files/" <> filename}
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
