defmodule TodoApiWeb.Router do
  use TodoApiWeb, :router
  use Plug.ErrorHandler

   defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
     conn
     |> json(%{errors: message})
     |> halt()
   end

   defp handle_errors(conn, %{reason: %{message: message}}) do
     conn
     |> json(%{errors: message})
     |> halt()
   end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TodoApiWeb.Auth.Pipeline
  end

  scope "/api", TodoApiWeb do
    pipe_through :api
    scope "v1", V1, as: "v1" do
      resources "/accounts", AccountController, only: [:create, :show, :update]
      post "/accounts/sign_in", AccountController, :sign_in
    end
  end

  scope "/api", TodoApiWeb do
    pipe_through [:api, :auth]
    scope "v1", V1, as: "v1" do
      resources "/todos", TodoController, except: [:new, :edit]
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:todo_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TodoApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
