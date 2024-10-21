defmodule Gcm3Web.SurveyController do
  use Gcm3Web, :controller
  alias Gcm3.Surveys

  def index(conn, _params) do
    surveys = Surveys.list_surveys()

    render(conn, :index, surveys: surveys)
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, survey} <- Surveys.fetch_survey(id) do
      render(conn, :show, survey: survey)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(html: Gcm3Web.ErrorHTML, json: Gcm3Web.ErrorJSON)
        |> render(:"404")
    end
  end
end
