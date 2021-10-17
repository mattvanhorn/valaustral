defmodule ValaustralWeb.SuggestionLiveTest do
  use ValaustralWeb.ConnCase

  import Phoenix.LiveViewTest
  import Valaustral.SuggestionsFixtures
  import Valaustral.AccountsFixtures

  @create_attrs %{body: "some body", done: true, title: "some title"}
  @update_attrs %{body: "some updated body", done: false, title: "some updated title"}
  @invalid_attrs %{body: nil, done: false, title: nil}

  defp setup_fixtures(_) do
    user = user_fixture()
    suggestion = suggestion_fixture(author: user)
    %{suggestion: suggestion, user: user}
  end

  describe "Index" do
    setup [:setup_fixtures]

    test "lists all suggestions", %{conn: conn, suggestion: suggestion, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _index_live, html} = live(conn, Routes.suggestion_index_path(conn, :index))

      assert html =~ "Listing Suggestions"
      assert html =~ suggestion.body
    end

    test "saves new suggestion", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.suggestion_index_path(conn, :index))

      assert index_live |> element("a", "New Suggestion") |> render_click() =~
               "New Suggestion"

      assert_patch(index_live, Routes.suggestion_index_path(conn, :new))

      assert index_live
             |> form("#suggestion-form", suggestion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#suggestion-form", suggestion: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.suggestion_index_path(conn, :index))

      assert html =~ "Suggestion created successfully"
      assert html =~ "some body"
    end

    test "updates suggestion in listing", %{conn: conn, suggestion: suggestion, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.suggestion_index_path(conn, :index))

      assert index_live |> element("#suggestion-#{suggestion.id} a", "Edit") |> render_click() =~
               "Edit Suggestion"

      assert_patch(index_live, Routes.suggestion_index_path(conn, :edit, suggestion))

      assert index_live
             |> form("#suggestion-form", suggestion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#suggestion-form", suggestion: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.suggestion_index_path(conn, :index))

      assert html =~ "Suggestion updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes suggestion in listing", %{conn: conn, suggestion: suggestion, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.suggestion_index_path(conn, :index))

      assert index_live |> element("#suggestion-#{suggestion.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#suggestion-#{suggestion.id}")
    end
  end

  describe "Show" do
    setup [:setup_fixtures]

    test "displays suggestion", %{conn: conn, suggestion: suggestion, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _show_live, html} = live(conn, Routes.suggestion_show_path(conn, :show, suggestion))

      assert html =~ "Show Suggestion"
      assert html =~ suggestion.body
    end

    test "updates suggestion within modal", %{conn: conn, suggestion: suggestion, user: user} do
      conn = log_in_user(conn, user)
      {:ok, show_live, _html} = live(conn, Routes.suggestion_show_path(conn, :show, suggestion))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Suggestion"

      assert_patch(show_live, Routes.suggestion_show_path(conn, :edit, suggestion))

      assert show_live
             |> form("#suggestion-form", suggestion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#suggestion-form", suggestion: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.suggestion_show_path(conn, :show, suggestion))

      assert html =~ "Suggestion updated successfully"
      assert html =~ "some updated body"
    end
  end
end
