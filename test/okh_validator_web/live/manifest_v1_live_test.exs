defmodule OkhValidatorWeb.Manifest_v1LiveTest do
  use OkhValidatorWeb.ConnCase

  import Phoenix.LiveViewTest
  import OkhValidator.ManifestFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_manifest_v1(_) do
    manifest_v1 = manifest_v1_fixture()
    %{manifest_v1: manifest_v1}
  end

  describe "Index" do
    setup [:create_manifest_v1]

    test "lists all manifests_v1", %{conn: conn, manifest_v1: manifest_v1} do
      {:ok, _index_live, html} = live(conn, Routes.manifest_v1_index_path(conn, :index))

      assert html =~ "Listing Manifests v1"
      assert html =~ manifest_v1.title
    end

    test "saves new manifest_v1", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.manifest_v1_index_path(conn, :index))

      assert index_live |> element("a", "New Manifest v1") |> render_click() =~
               "New Manifest v1"

      assert_patch(index_live, Routes.manifest_v1_index_path(conn, :new))

      assert index_live
             |> form("#manifest_v1-form", manifest_v1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#manifest_v1-form", manifest_v1: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.manifest_v1_index_path(conn, :index))

      assert html =~ "Manifest v1 created successfully"
      assert html =~ "some title"
    end

    test "updates manifest_v1 in listing", %{conn: conn, manifest_v1: manifest_v1} do
      {:ok, index_live, _html} = live(conn, Routes.manifest_v1_index_path(conn, :index))

      assert index_live |> element("#manifest_v1-#{manifest_v1.id} a", "Edit") |> render_click() =~
               "Edit Manifest v1"

      assert_patch(index_live, Routes.manifest_v1_index_path(conn, :edit, manifest_v1))

      assert index_live
             |> form("#manifest_v1-form", manifest_v1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#manifest_v1-form", manifest_v1: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.manifest_v1_index_path(conn, :index))

      assert html =~ "Manifest v1 updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes manifest_v1 in listing", %{conn: conn, manifest_v1: manifest_v1} do
      {:ok, index_live, _html} = live(conn, Routes.manifest_v1_index_path(conn, :index))

      assert index_live |> element("#manifest_v1-#{manifest_v1.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#manifest_v1-#{manifest_v1.id}")
    end
  end

  describe "Show" do
    setup [:create_manifest_v1]

    test "displays manifest_v1", %{conn: conn, manifest_v1: manifest_v1} do
      {:ok, _show_live, html} = live(conn, Routes.manifest_v1_show_path(conn, :show, manifest_v1))

      assert html =~ "Show Manifest v1"
      assert html =~ manifest_v1.title
    end

    test "updates manifest_v1 within modal", %{conn: conn, manifest_v1: manifest_v1} do
      {:ok, show_live, _html} = live(conn, Routes.manifest_v1_show_path(conn, :show, manifest_v1))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Manifest v1"

      assert_patch(show_live, Routes.manifest_v1_show_path(conn, :edit, manifest_v1))

      assert show_live
             |> form("#manifest_v1-form", manifest_v1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#manifest_v1-form", manifest_v1: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.manifest_v1_show_path(conn, :show, manifest_v1))

      assert html =~ "Manifest v1 updated successfully"
      assert html =~ "some updated title"
    end
  end
end
