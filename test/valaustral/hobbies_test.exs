defmodule Valaustral.HobbiesTest do
  use Valaustral.DataCase

  alias Valaustral.Hobbies

  describe "hobbies" do
    alias Valaustral.Hobbies.Hobby

    import Valaustral.HobbiesFixtures
    import Valaustral.AccountsFixtures

    @invalid_attrs %{name: nil}

    test "list_user_hobbies/1 returns all hobbies" do
      user = user_fixture()
      hobby = hobby_fixture(%{user_id: user.id})
      assert Hobbies.list_user_hobbies(user) == [hobby]
    end

    test "get_hobby!/1 returns the hobby with given id" do
      user = user_fixture()
      hobby = hobby_fixture(%{user_id: user.id})
      assert Hobbies.get_hobby!(hobby.id) == hobby
    end

    test "create_hobby/1 with valid data creates a hobby" do
      user = user_fixture()
      valid_attrs = %{name: "some name", user_id: user.id}

      assert {:ok, %Hobby{} = hobby} = Hobbies.create_hobby(valid_attrs)
      assert hobby.name == "some name"
    end

    test "create_hobby/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hobbies.create_hobby(@invalid_attrs)
    end

    test "update_hobby/2 with valid data updates the hobby" do
      user = user_fixture()
      hobby = hobby_fixture(%{user: user})
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Hobby{} = hobby} = Hobbies.update_hobby(hobby, update_attrs)
      assert hobby.name == "some updated name"
    end

    test "update_hobby/2 with invalid data returns error changeset" do
      user = user_fixture()
      hobby = hobby_fixture(%{user: user})
      assert {:error, %Ecto.Changeset{}} = Hobbies.update_hobby(hobby, @invalid_attrs)
      assert hobby == Hobbies.get_hobby!(hobby.id)
    end

    test "delete_hobby/1 deletes the hobby" do
      user = user_fixture()
      hobby = hobby_fixture(%{user_id: user.id})
      assert {:ok, %Hobby{}} = Hobbies.delete_hobby(hobby)
      assert_raise Ecto.NoResultsError, fn -> Hobbies.get_hobby!(hobby.id) end
    end

    test "change_hobby/1 returns a hobby changeset" do
      user = user_fixture()
      hobby = hobby_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Hobbies.change_hobby(hobby)
    end
  end
end
