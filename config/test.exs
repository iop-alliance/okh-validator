import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :okh_validator, OkhValidator.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "okh_validator_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :okh_validator, OkhValidatorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xyRPXvJpjgl63pZOBhJNI1Ck+wo06MTm7s4cbeKujjMfYF8oPVV8eGd9umA0Qshr",
  server: false

# In test we don't send emails.
config :okh_validator, OkhValidator.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
