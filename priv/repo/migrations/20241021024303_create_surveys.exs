defmodule Gcm3.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :ANSWERS, :map

      timestamps(type: :utc_datetime, updated_at: false)
    end
  end
end
