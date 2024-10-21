defmodule Gcm3.SurveysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gcm3.Surveys` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        answers: %{}
      })
      |> Gcm3.Surveys.create_survey()

    survey
  end
end
