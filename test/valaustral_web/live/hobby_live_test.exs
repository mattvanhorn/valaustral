defmodule ValaustralWeb.HobbyLiveTest do
  use ValaustralWeb.ConnCase

  import Phoenix.LiveViewTest
  import Valaustral.HobbiesFixtures
  import Valaustral.AccountsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  # defp create_user(_) do
  #   user = user_fixture()
  #   %{user: user}
  # end

  # defp create_hobby(_) do
  #   hobby = hobby_fixture()
  #   %{hobby: hobby}
  # end

  defp setup_fixtures(_) do
    user = user_fixture()
    hobby = hobby_fixture(user_id: user.id)
    %{hobby: hobby, user: user}
  end

  describe "Index" do
    setup [:setup_fixtures]

    test "lists all hobbies", %{conn: conn, hobby: hobby, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _index_live, html} = live(conn, Routes.hobby_index_path(conn, :index))

      assert html =~ "Listing Hobbies"
      assert html =~ hobby.name
    end

    test "saves new hobby", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)

      {:ok, index_live, _html} = live(conn, Routes.hobby_index_path(conn, :index))

      assert index_live |> element("a", "New Hobby") |> render_click() =~
               "New Hobby"

      assert_patch(index_live, Routes.hobby_index_path(conn, :new))

      assert index_live
             |> form("#hobby-form", hobby: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hobby-form", hobby: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hobby_index_path(conn, :index))

      assert html =~ "Hobby created successfully"
      assert html =~ "some name"
    end

    test "updates hobby in listing", %{conn: conn, hobby: hobby, user: user} do
      conn = log_in_user(conn, user)

      {:ok, index_live, _html} = live(conn, Routes.hobby_index_path(conn, :index))

      assert index_live |> element("#hobby-#{hobby.id} a", "Edit") |> render_click() =~
               "Edit Hobby"

      assert_patch(index_live, Routes.hobby_index_path(conn, :edit, hobby))

      assert index_live
             |> form("#hobby-form", hobby: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hobby-form", hobby: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hobby_index_path(conn, :index))

      assert html =~ "Hobby updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes hobby in listing", %{conn: conn, hobby: hobby, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.hobby_index_path(conn, :index))

      assert index_live |> element("#hobby-#{hobby.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hobby-#{hobby.id}")
    end
  end

  describe "Show" do
    setup [:setup_fixtures]

    test "displays hobby", %{conn: conn, hobby: hobby, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _show_live, html} = live(conn, Routes.hobby_show_path(conn, :show, hobby))

      assert html =~ "Show Hobby"
      assert html =~ hobby.name
    end

    test "updates hobby within modal", %{conn: conn, hobby: hobby, user: user} do
      conn = log_in_user(conn, user)
      {:ok, show_live, _html} = live(conn, Routes.hobby_show_path(conn, :show, hobby))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hobby"

      assert_patch(show_live, Routes.hobby_show_path(conn, :edit, hobby))

      assert show_live
             |> form("#hobby-form", hobby: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#hobby-form", hobby: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hobby_show_path(conn, :show, hobby))

      assert html =~ "Hobby updated successfully"
      assert html =~ "some updated name"
    end
  end
end
