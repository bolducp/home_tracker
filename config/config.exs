# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :home_tracker,
  ecto_repos: [HomeTracker.Repo]

# Configures the endpoint
config :home_tracker, HomeTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UYKWyvYmfbkCticqmye88xElyjsw8uUV2dadM8sfPJMyVMZEYL/xI/7ezUgFON0P",
  render_errors: [view: HomeTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HomeTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
