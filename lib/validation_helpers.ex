defmodule V1ValidationHelpers do
  def validate_date(maybe_date, field) do
    case Regex.match?(~r/^\d{4}-\d{2}-\d{2}$/, maybe_date) do
      true ->
        %{field => %{status: "ok", value: maybe_date}}
      false ->
        %{field => %{status: "error", value: maybe_date, message: "Invalid date format"}}
    end
  end

  def validate_email(maybe_email) do
    case Regex.run(~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, maybe_email) do
      nil ->
        %{status: "error", value: maybe_email, message: "Invalid email"}
      _ ->
        %{status: "ok", value: maybe_email}
    end
  end
end
