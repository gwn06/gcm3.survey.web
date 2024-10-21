defmodule Gcm3.Repo do
  use Ecto.Repo,
    otp_app: :gcm3,
    adapter: Ecto.Adapters.Postgres
end
