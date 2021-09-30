defmodule SessionLiveviewDebugWeb.PageLive do
  use SessionLiveviewDebugWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <form phx-change="name-changed">
        <%= content_tag "select", name: "name" do %>
          <%= options_for_select ["Daniel", "Cevado", "Valim"], @name %>
        <% end %>
      </form>

      <p>Current Name: <%= @name %></p>


      <%= live_patch "Page", to: Routes.page_path(@socket, :index) %>
      <%= live_redirect "Page2", to: Routes.page2_path(@socket, :index) %>
    """
  end

  @impl true
  def mount(params, session, socket) do
    IO.inspect([params, session, socket])

    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)
      |> put_session_assigns(session)

    {:ok, socket}
  end

  @impl true
  def handle_info({:live_session_updated, session}, socket) do
    IO.inspect(session, label: "live_session_updated")
    {:noreply, put_session_assigns(socket, session)}
  end

  @impl true
  def handle_event("name-changed", %{"name" => name}, socket) do
    PhoenixLiveSession.put_session(socket, "name", name)

    {:noreply, socket}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(:name, Map.get(session, "name", "Daniel"))
  end
end
