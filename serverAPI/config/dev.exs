use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :VialRackAPI, VialRackAPI.Endpoint,
	http: [port: 4000],
	debug_errors: true,
	code_reloader: true,
	check_origin: false,
	watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
										cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :VialRackAPI, VialRackAPI.Endpoint,
	live_reload: [
		patterns: [
			~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
			~r{priv/gettext/.*(po)$},
			~r{web/views/.*(ex)$},
			~r{web/templates/.*(eex)$}
		]
	]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :VialRackAPI, VialRackAPI.Repo,
	adapter: Sqlite.Ecto2,
	database: "VialRackAPI.sqlite3"
'''
config :VialRackAPI, VialRackAPI.Repo,
	adapter: Ecto.Adapters.MySQL,
	username: "elixir",
	password: "E1=Vv(1wg34t",
	database: "elixirAPI",
	hostname: "localhost",
	pool_size: 10
	'''
