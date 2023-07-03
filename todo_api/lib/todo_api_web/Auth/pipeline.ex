defmodule TodoApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :todo_app,
      module: TodoApiWeb.Auth.Guardian,
      error_handler: TodoApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end