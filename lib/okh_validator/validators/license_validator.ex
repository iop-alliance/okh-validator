defmodule Validators.LicenseValidator do
  alias ValidationHelpers

  def validate_license(validations, fields) do
    case Map.get(fields, "license") do
      nil ->
        Map.merge(validations, %{"license" => "not found"})
      _ ->
        %{"license" => license} = fields

        license_validations =
          %{}
          |> validate_documentation_license(license)
          |> validate_software_license(license)
          |> validate_hardware_license(license)
          |> validate_at_least_one_valid_license()

          Map.merge(validations, %{"license" => %{status: "ok", validations: license_validations}})
    end
  end

  defp validate_documentation_license(license_validations, license) do
    case Map.get(license, "documentation") do
      nil ->
        Map.merge(license_validations, %{documentation: %{status: "not found"}})
      _ ->
        %{"documentation" => documentation_license} = license
        Map.merge(license_validations, %{documentation: %{status: "ok", value: documentation_license}})
    end
  end

  defp validate_software_license(license_validations, license) do
    case Map.get(license, "software") do
      nil ->
        Map.merge(license_validations, %{software: %{status: "not found"}})
      _ ->
        %{"software" => software_license} = license
        Map.merge(license_validations, %{software: %{status: "ok", value: software_license}})
    end
  end

  defp validate_hardware_license(license_validations, license) do
    case Map.get(license, "hardware") do
      nil ->
        Map.merge(license_validations, %{hardware: %{status: "not found"}})
      _ ->
        %{"hardware" => hardware_license} = license
        Map.merge(license_validations, %{hardware: %{status: "ok", value: hardware_license}})
    end
  end

  defp validate_at_least_one_valid_license(license_validations) do
    %{
      documentation: %{status: documentation_status}
    } = license_validations
    case documentation_status do
      "ok" ->
        %{status: "ok", validations: license_validations}
      "not found" ->
        %{status: "error", message: "at least one valid license is required", validations: license_validations}
    end
  end
end
