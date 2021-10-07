defmodule Valaustral.Repo do
  use Ecto.Repo,
    otp_app: :valaustral,
    adapter: Ecto.Adapters.Postgres
end
