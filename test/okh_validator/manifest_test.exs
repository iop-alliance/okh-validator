defmodule OkhValidator.ManifestTest do
  use OkhValidator.DataCase

  alias OkhValidator.Manifest

  describe "manifests_v1" do
    alias OkhValidator.Manifest.Manifest_v1

    import OkhValidator.ManifestFixtures

    @invalid_attrs %{title: nil}

    test "list_manifests_v1/0 returns all manifests_v1" do
      manifest_v1 = manifest_v1_fixture()
      assert Manifest.list_manifests_v1() == [manifest_v1]
    end

    test "get_manifest_v1!/1 returns the manifest_v1 with given id" do
      manifest_v1 = manifest_v1_fixture()
      assert Manifest.get_manifest_v1!(manifest_v1.id) == manifest_v1
    end

    test "create_manifest_v1/1 with valid data creates a manifest_v1" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Manifest_v1{} = manifest_v1} = Manifest.create_manifest_v1(valid_attrs)
      assert manifest_v1.title == "some title"
    end

    test "create_manifest_v1/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Manifest.create_manifest_v1(@invalid_attrs)
    end

    test "update_manifest_v1/2 with valid data updates the manifest_v1" do
      manifest_v1 = manifest_v1_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Manifest_v1{} = manifest_v1} = Manifest.update_manifest_v1(manifest_v1, update_attrs)
      assert manifest_v1.title == "some updated title"
    end

    test "update_manifest_v1/2 with invalid data returns error changeset" do
      manifest_v1 = manifest_v1_fixture()
      assert {:error, %Ecto.Changeset{}} = Manifest.update_manifest_v1(manifest_v1, @invalid_attrs)
      assert manifest_v1 == Manifest.get_manifest_v1!(manifest_v1.id)
    end

    test "delete_manifest_v1/1 deletes the manifest_v1" do
      manifest_v1 = manifest_v1_fixture()
      assert {:ok, %Manifest_v1{}} = Manifest.delete_manifest_v1(manifest_v1)
      assert_raise Ecto.NoResultsError, fn -> Manifest.get_manifest_v1!(manifest_v1.id) end
    end

    test "change_manifest_v1/1 returns a manifest_v1 changeset" do
      manifest_v1 = manifest_v1_fixture()
      assert %Ecto.Changeset{} = Manifest.change_manifest_v1(manifest_v1)
    end
  end
end
