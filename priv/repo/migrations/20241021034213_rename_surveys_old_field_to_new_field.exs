defmodule Gcm3.Repo.Migrations.RenameSurveysOldFieldToNewField do
  use Ecto.Migration

  def change do
    rename table(:surveys), :ANSWERS, to: :answers
  end
end
