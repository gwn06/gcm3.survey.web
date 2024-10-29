defmodule Gcm3Web.SurveyLive do
  use Gcm3Web, :live_view

  alias Gcm3.Surveys.Survey
  alias Gcm3.Surveys

  def render(assigns) do
    ~H"""
    <div class="w-full">
      <.flash title="Survey submitted!" kind={:info} flash={@flash} />
      <.simple_form id="survey_form" for={@changeset} phx-submit="save" phx-change="validate">
        <%= for {question_key, question} <- @questions do %>
          <div class="mx-2 sm:mx-6 p-2 border-t-[6px] border border-gray-200 shadow  border-t-sky-800 ">
            <.header class="mb-6 mx-4 font-medium"><%= question %></.header>

            <div class="mb-5 mx-4 sm:mx-20 flex flex-wrap justify-center xl:justify-around">
              <%= for {selection, value} <- @answers_selection do %>
                <div class="my-4 xl:mt-0 text-sm md:text-base px-2">
                  <input
                    id={"#{question_key <> selection}"}
                    type="radio"
                    name={question_key}
                    value={value}
                    class="hidden peer"
                    checked={@changeset.changes[:answers][question_key] == value}
                    phx-throttle="5000"
                  />
                  <label
                    for={"#{question_key <> selection}"}
                    class="peer-checked:bg-sky-800  peer-checked:text-zinc-50 peer-checked:border-zinc-600  p-2 border border-[3px] rounded-xl
                      border-zinc-400 text-zinc-500 transition-all duration-100  hover:border-sky-800 hover:text-zinc-100 hover:text-zinc-800"
                  >
                    <%= selection %>
                  </label>
                </div>
              <% end %>
            </div>

            <%= if error = get_error(@changeset, question_key) do %>
              <.error><%= get_error_value(error) %></.error>
            <% end %>
          </div>
        <% end %>

        <.button
          class={"mx-6 mb-6  disabled:bg-gray-500 hover:bg-gray-500 #{if !@changeset.valid?, do: "pointer-events-none"}"}
          phx-disable-with="Submitting..."
          disabled={!@changeset.valid?}
        >
          Submit
        </.button>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    questions = [
      {"Q1", "1. I worry about things."},
      {"Q2", "2. I make friends easily."},
      {"Q3", "3. I have a vivid imagination."}
    ]

    answers_selection = [
      {"Very Inaccurate", "1"},
      {"Moderately Inaccurate", "2"},
      {"Neither Accurate Nor Inaccurate", "3"},
      {"Moderately Accurate", "4"},
      {"Very Accurate", "5"}
    ]

    changeset = Surveys.change_survey(%Survey{})

    socket =
      socket
      |> assign(
        questions: questions,
        answers_selection: answers_selection,
        changeset: changeset
      )

    {:ok, socket, layout: false}
  end

  def handle_event("save", _params, socket) do
    case Surveys.create_survey(socket.assigns.changeset.changes) do
      {:ok, _survey} ->
        new_changeset = Surveys.change_survey(%Survey{})

        {:noreply,
         socket
         |> assign(changeset: new_changeset)
         |> put_flash(:info, " You can check out /api/surveys to see all data. ")}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {:noreply, socket}
    end
  end

  def handle_event("validate", params, socket) do
    attrs = Map.delete(params, "_target")
    changeset = Surveys.change_survey(%Survey{}, %{"answers" => attrs})

    changeset =
      Enum.reduce(socket.assigns.questions, changeset, fn {key, _value}, changeset ->
        if is_nil(attrs[key]) do
          Ecto.Changeset.add_error(changeset, key, "Question #{String.last(key)} is missing.")
        else
          changeset
        end
      end)

    {:noreply, assign(socket, changeset: Map.put(changeset, :action, :validate))}
  end

  def get_error(changeset, key) do
    Enum.find(changeset.errors, fn {k, _v} -> k == key end)
  end

  def get_error_value(error) do
    {_key, {value, _}} = error
    value
  end
end
