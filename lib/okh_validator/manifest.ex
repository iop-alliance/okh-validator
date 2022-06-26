defmodule OkhValidator.Manifest do
  @moduledoc """
  The Manifest context.
  """

  import Ecto.Query, warn: false
  alias OkhValidator.Repo

  alias OkhValidator.Manifest.Manifest_v1

  @doc """
  Returns the list of manifests_v1.

  ## Examples

      iex> list_manifests_v1()
      [%Manifest_v1{}, ...]

  """
  def list_manifests_v1 do
    Repo.all(Manifest_v1)
  end

  @doc """
  Gets a single manifest_v1.

  Raises `Ecto.NoResultsError` if the Manifest v1 does not exist.

  ## Examples

      iex> get_manifest_v1!(123)
      %Manifest_v1{}

      iex> get_manifest_v1!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manifest_v1!(id), do: Repo.get!(Manifest_v1, id)

  @doc """
  Creates a manifest_v1.

  ## Examples

      iex> create_manifest_v1(%{field: value})
      {:ok, %Manifest_v1{}}

      iex> create_manifest_v1(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manifest_v1(attrs \\ %{}) do
    %Manifest_v1{}
    |> Manifest_v1.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manifest_v1.

  ## Examples

      iex> update_manifest_v1(manifest_v1, %{field: new_value})
      {:ok, %Manifest_v1{}}

      iex> update_manifest_v1(manifest_v1, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manifest_v1(%Manifest_v1{} = manifest_v1, attrs) do
    manifest_v1
    |> Manifest_v1.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a manifest_v1.

  ## Examples

      iex> delete_manifest_v1(manifest_v1)
      {:ok, %Manifest_v1{}}

      iex> delete_manifest_v1(manifest_v1)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manifest_v1(%Manifest_v1{} = manifest_v1) do
    Repo.delete(manifest_v1)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manifest_v1 changes.

  ## Examples

      iex> change_manifest_v1(manifest_v1)
      %Ecto.Changeset{data: %Manifest_v1{}}

  """
  def change_manifest_v1(%Manifest_v1{} = manifest_v1, attrs \\ %{}) do
    Manifest_v1.changeset(manifest_v1, attrs)
  end
end
