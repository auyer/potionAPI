defmodule VialRackAPI.StoreFile do

	@moduledoc """
	Responsible for managing files (Uploading and deletion).
	"""

	@dir "priv"

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
			case File.write("#{@dir}/static/files/#{filename}", binary) do
				:ok -> {:ok, "/static/files/" <> filename}
				{:error, reason}-> {:error, reason}
			end
		{:error} -> {:error,"Error Converting from Base 64"}
		end
	end

	@doc """
	Accepts a VialRackAPI.File struct and deletes it.

	## Examples

			iex> delete(file)

						Expected output  :ok
						Error output     {:error, reason}

	"""

	def delete(%{file: path}) do
		case File.rm("#{@dir}#{path}") do
			:ok -> :ok
			{:error, reason}-> {:error, reason}
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
