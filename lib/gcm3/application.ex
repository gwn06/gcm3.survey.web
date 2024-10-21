defmodule Gcm3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Gcm3Web.Telemetry,
      Gcm3.Repo,
      {DNSCluster, query: Application.get_env(:gcm3, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Gcm3.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Gcm3.Finch},
      # Start a worker by calling: Gcm3.Worker.start_link(arg)
      # {Gcm3.Worker, arg},
      # Start to serve requests, typically the last entry
      Gcm3Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gcm3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Gcm3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
