defmodule Gcm3.SurveysTest do
  use Gcm3.DataCase

  alias Gcm3.Surveys

  describe "surveys" do
    alias Gcm3.Surveys.Survey

    import Gcm3.SurveysFixtures

    @invalid_attrs %{answers: nil}

    test "list_surveys/0 returns all surveys" do
      survey = survey_fixture()
      assert Surveys.list_surveys() == [survey]
    end

    test "fetch_survey/1 returns the survey with given id" do
      survey = survey_fixture()
      assert Surveys.fetch_survey(survey.id) == {:ok, survey}
    end

    test "create_survey/1 with valid data creates a survey" do
      valid_attrs = %{answers: %{"Q1" => "1", "Q2" => "3", "Q3" => "5"}}

      assert {:ok, %Survey{} = survey} = Surveys.create_survey(valid_attrs)
      assert survey.answers == %{"Q1" => "1", "Q2" => "3", "Q3" => "5"}
    end

    test "create_survey/1 with empty data creates a survey" do
      valid_attrs = %{answers: %{}}

      assert {:ok, %Survey{} = survey} = Surveys.create_survey(valid_attrs)
      assert survey.answers == %{}
    end

    test "create_survey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_survey(@invalid_attrs)
    end

    test "delete_survey/1 deletes the survey" do
      survey = survey_fixture()
      assert {:ok, %Survey{}} = Surveys.delete_survey(survey)

      assert {:error, :not_found} = Surveys.fetch_survey(survey.id)
      # assert_raise Ecto.NoResultsError, fn -> Surveys.get_survey!(survey.id) end
    end

    test "change_survey/1 returns a survey changeset" do
      survey = survey_fixture()
      assert %Ecto.Changeset{} = Surveys.change_survey(survey)
    end
  end
end
