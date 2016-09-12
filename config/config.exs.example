# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :t_r, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:t_r, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :t_r,
  message_size: 100,
  phone: 375299707359,
  data_file_path: "/home/virviil/data.txt",
  time_file_path: "/home/virviil/time.txt"

config :tg_client,
  daemon: "~/Downloads/tg/bin/telegram-cli",
  key: "~/Downloads/tg/tg-server.pub",
  session_env_path: "/tmp/telegram-cli/sessions",
  port_range: 2000..4000,
  default_pool_size: 5,
  default_pool_max_overflow: 10,
  pool_name: :event_handler,
  event_handler: {TR.EventHandler, size: 10, max_overflow: 10}

config :quantum, cron: [
  "0 * * * *": {TR.Api, :write_to_file}
]
