defmodule TodoApiWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: :unauthorized
end

defmodule TodoApiWeb.Auth.ErrorResponse.NotFound do
  defexception message: "Not Found", plug_status: :not_found
end