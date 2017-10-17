use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :serverAPI, ServerAPI.Endpoint,
  secret_key_base: "gxLL2haHDS7beZ9lw2S3yPoiQBSvdo7Z+kA5rhFqzoMtbeGOyh6c8wepprYCikq8"

# Configure your database
config :serverAPI, ServerAPI.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "serverapi_prod",
  pool_size: 20
