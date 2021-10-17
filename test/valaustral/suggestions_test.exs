defmodule Valaustral.SuggestionsTest do
  use Valaustral.DataCase

  alias Valaustral.Suggestions

  describe "suggestions" do
    alias Valaustral.Suggestions.Suggestion

    import Valaustral.AccountsFixtures
    import Valaustral.SuggestionsFixtures

    @invalid_attrs %{body: nil, done: nil, title: nil}

    test "list_suggestions/0 returns all suggestions" do
      suggestion = suggestion_fixture(%{author: user_fixture()})
      assert Suggestions.list_suggestions() == [suggestion]
    end

    test "get_suggestion!/1 returns the suggestion with given id" do
      suggestion = suggestion_fixture(%{author: user_fixture()})
      assert Suggestions.get_suggestion!(suggestion.id) == suggestion
    end

    test "create_suggestion/1 with valid data creates a suggestion" do
      valid_attrs = %{author: user_fixture(), body: "some body", done: true, title: "some title"}

      assert {:ok, %Suggestion{} = suggestion} = Suggestions.create_suggestion(valid_attrs)
      assert suggestion.body == "some body"
      assert suggestion.done == true
      assert suggestion.title == "some title"
    end

    test "create_suggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suggestions.create_suggestion(@invalid_attrs)
    end

    test "update_suggestion/2 with valid data updates the suggestion" do
      suggestion = suggestion_fixture(%{author: user_fixture()})
      update_attrs = %{body: "some updated body", done: false, title: "some updated title"}

      assert {:ok, %Suggestion{} = suggestion} =
               Suggestions.update_suggestion(suggestion, update_attrs)

      assert suggestion.body == "some updated body"
      assert suggestion.done == false
      assert suggestion.title == "some updated title"
    end

    test "update_suggestion/2 with invalid data returns error changeset" do
      suggestion = suggestion_fixture(%{author: user_fixture()})

      assert {:error, %Ecto.Changeset{}} =
               Suggestions.update_suggestion(suggestion, @invalid_attrs)

      assert suggestion == Suggestions.get_suggestion!(suggestion.id)
    end

    test "delete_suggestion/1 deletes the suggestion" do
      suggestion = suggestion_fixture(%{author: user_fixture()})
      assert {:ok, %Suggestion{}} = Suggestions.delete_suggestion(suggestion)
      assert_raise Ecto.NoResultsError, fn -> Suggestions.get_suggestion!(suggestion.id) end
    end

    test "change_suggestion/1 returns a suggestion changeset" do
      suggestion = suggestion_fixture(%{author: user_fixture()})
      assert %Ecto.Changeset{} = Suggestions.change_suggestion(suggestion)
    end
  end
end
