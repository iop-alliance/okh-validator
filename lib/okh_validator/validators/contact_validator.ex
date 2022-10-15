# TODO
# - add field validations
# - Rules: Where used, provide at least one email address or social media user handle

defmodule Validators.ContactValidator do
  alias V1ValidationHelpers

  def validate_contact(validations, fields) do
    case Map.get(fields, "contact") do
      nil ->
        Map.merge(validations, %{"contact" => %{status: "not found"}})
      _ ->
        %{"contact" => field} = fields
        Map.merge(validations, %{"contact" => %{status: "ok", value: field}})

        # manifest_author_validations =
        #   validations.manifest_author
        #   |> validate_manifest_author_name(field)
        #   |> validate_manifest_author_affiliation(field)
        #   |> validate_manifest_author_email(field)

        # Map.merge(validations, %{manifest_author: {:ok, manifest_author_validations}})
    end
  end
end
