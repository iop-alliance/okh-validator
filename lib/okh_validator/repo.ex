defmodule OkhValidator.Repo do
  use Ecto.Repo,
    otp_app: :okh_validator,
    adapter: Ecto.Adapters.Postgres
end
