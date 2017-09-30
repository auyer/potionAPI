# potionAPI Project,

## How it Works:

This API will take Base64 encoded files as an argument in a JSON, metadata and the File Extension.

	{
		"file": "dGVzdApmaWxlCg==",
		"metadata": {
			"name" : "Test File"
		},
		"ext": "txt"
	}
	
The API will store the file and return th URL in the JSON response.

	[
		{
			"metadata": {
				"name": "Test File"
			},
			"file": "/files/3038c41cbbb04aefbf48ed3fc3baeb2e.txt",
			"ext": "txt"
		}
	]


The available methods are:

* #### GET "/files" :
Will list all Files

* #### GET "/file/:id"
Will show all the info on a File with the provided ID
	
* #### POST "/file" with a valid JSON,
will upload and create a new file.

	
* #### POST "/file/:id", FileController, :update
Will update DATA on a existing file. ( This will not re-upload the file)
	
* #### DELETE "/file/:id", FileController, :delete
Will delete a file with the provided ID

## Installing the Server

#### macOS: 	
##### Option 1 - Homebrew:

If you dont have it already, install HomeBrew running this command:

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Then install Elixir

	brew update && brew install elixir

##### Option 2 - Macports:
Download Macports here: https://www.macports.org/install.php
Then:

	sudo port install elixir


#### Fedora
	dnf install elixir

#### Ubuntu and Debian:
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
	sudo apt-get update
	sudo apt-get install esl-erlang elixir

### Running:

First Download the dependencies and create the database ( configured in configured in "serverAPI/config/dev.exs" )

	mix deps.get
	mix ecto.create

We are all set! Run your Phoenix application:

	cd serverAPI
	mix phoenix.server

You can also run your app inside IEx (Interactive Elixir) as:

	iex -S mix phoenix.server



#############
