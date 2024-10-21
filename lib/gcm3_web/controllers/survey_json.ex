defmodule Gcm3Web.SurveyJSON do
  alias Gcm3.Surveys.Survey

  def index(%{surveys: surveys}) do
    %{data: for(survey <- surveys, do: data(survey))}
  end

  def show(%{survey: survey}) do
    %{data: data(survey)}
  end

  defp data(%Survey{} = survey) do
    %{
      id: survey.id,
      answers: survey.answers,
      inserted_at: survey.inserted_at
    }
  end
end
