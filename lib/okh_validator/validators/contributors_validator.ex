# TODO
# - Make this a person validator for use with other fields
# - validate individual contributor fields (https://standards.internetofproduction.org/pub/okh#contributors) and ensure that name is present for each

defmodule Validators.ContributorsValidator do
  alias V1ValidationHelpers

  def validate_contributors(validations, fields) do
    case Map.get(fields, "contributors") do
      nil ->
        Map.merge(validations, %{contributors: %{status: "not found"}})
      _ ->
        %{"contributors" => field} = fields
        Map.merge(validations, %{contributors: %{status: "ok", value: field}})
        # manifest_author_validations =
        #   validations.manifest_author
        #   |> validate_manifest_author_name(field)
        #   |> validate_manifest_author_affiliation(field)
        #   |> validate_manifest_author_email(field)

        # Map.merge(validations, %{manifest_author: {:ok, manifest_author_validations}})
    end
  end
end
