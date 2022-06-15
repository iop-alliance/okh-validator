defmodule OkhValidatorWeb.ValidationView do
  use OkhValidatorWeb, :view

  def render("index.json", %{validation_response: validation_response}) do
    validation_response
  end
end
