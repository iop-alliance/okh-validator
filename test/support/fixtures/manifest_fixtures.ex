defmodule OkhValidator.ManifestFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OkhValidator.Manifest` context.
  """

  @doc """
  Generate a manifest_v1.
  """
  def manifest_v1_fixture(attrs \\ %{}) do
    {:ok, manifest_v1} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> OkhValidator.Manifest.create_manifest_v1()

    manifest_v1
  end
end
