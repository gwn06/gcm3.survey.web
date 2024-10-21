defmodule Gcm3.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :answers, :map

    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:answers])
    |> validate_required([:answers])
  end
end
