defmodule SessionLiveviewDebug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SessionLiveviewDebugWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SessionLiveviewDebug.PubSub},
      # Start the Endpoint (http/https)
      SessionLiveviewDebugWeb.Endpoint
      # Start a worker by calling: SessionLiveviewDebug.Worker.start_link(arg)
      # {SessionLiveviewDebug.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SessionLiveviewDebug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SessionLiveviewDebugWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
