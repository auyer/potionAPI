# vialRackAPI Project,
An elixir API for file serving and storage, also keeping its metadata in a Database.

## How it Works:

This API will take Base64 encoded files as an argument in a JSON, metadata and the File Extension.

	{
		"metadata": {
			"name" : "Test File",
			"type" : "Anything you want"
		},
		"file": "dGVzdApmaWxlCg==",
		"ext": "txt"
	}

The API will store the file and return th URL in the JSON response.

	[
		{
			"metadata": {
				"name": "Test File",
				"type" : "Anything you want"
			},
			"id": 1,
			"file": "/files/3038c41cbbb04aefbf48ed3fc3baeb2e.txt",
			"ext": "txt"
		}
	]


The available methods are:

* #### GET "/api/list" :
Will list all Files

* #### POST "/api/new" with a valid JSON,
will upload and create a new file.

* #### GET "/api/file/:id"
Will show all the info on a File with the provided ID

* #### POST "/file/:id"
Will update DATA on a existing file. ( This will not re-upload the file)

* #### DELETE "/file/:id"
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

First Download the dependencies and create the database ( configured in configured in "vialRackAPI/config/dev.exs" )

	mix deps.get
	mix ecto.create

We are all set! Run your Phoenix application:

	cd vialRackAPI
	mix phoenix.server

You can also run your app inside IEx (Interactive Elixir) as:

	iex -S mix phoenix.server



#############
