defmodule Validators.PersonValidator do
  alias ValidationHelpers

  def validate_person_field(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields

        # person_validations =
        #   person
        #   |> validate_person_name(field)
        #   |> validate_person_affiliation(field)
        #   |> validate_person_email(field)

        Map.merge(validations, %{field => %{status: "ok", value: value}})
    end
  end

  # defp validate_person_name(person_validations, person) do
  #   case Map.get(person, "name") do
  #     nil ->
  #       Map.merge(person_validations, %{name: {:error, %{value: nil, message: "not found"}}})
  #     _ ->
  #       %{"name" => name} = person
  #       Map.merge(person_validations, %{name: {:ok, name}})
  #   end
  # end

  # defp validate_person_affiliation(person_validations, person) do
  #   case Map.get(person, "affiliation") do
  #     nil ->
  #       Map.merge(person_validations, %{affiliation: {:error, %{value: nil, message: "not found"}}})
  #     _ ->
  #       %{"affiliation" => affiliation} = person
  #       Map.merge(person_validations, %{affiliation: {:ok, affiliation}})
  #   end
  # end

  # defp validate_person_email(person_validations, person) do
  #   case Map.get(person_validations, "affiliation") do
  #     nil ->
  #       Map.merge(person_validations, %{email: {:error, %{value: nil, message: "not found"}}})
  #     _ ->
  #       %{"email" => email} = person
  #       Map.merge(person_validations, %{email: ValidationHelpers.validate_email(email)})
  #   end
  # end
end
