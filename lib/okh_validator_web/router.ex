defmodule OkhValidatorWeb.Router do
  use OkhValidatorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OkhValidatorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OkhValidatorWeb do
    pipe_through :browser

    live "/", PageLive, :index
    # live "/manifests_v1", Manifest_v1Live.Index, :index
    # live "/manifests_v1/new", Manifest_v1Live.Index, :new
    # live "/manifests_v1/:id/edit", Manifest_v1Live.Index, :edit

    # live "/manifests_v1/:id", Manifest_v1Live.Show, :show
    # live "/manifests_v1/:id/show/edit", Manifest_v1Live.Show, :edit
  end

  # Other scopes may use custom stacks.
  scope "/api", OkhValidatorWeb do
    pipe_through :api

    get "/validate", ValidationController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OkhValidatorWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
