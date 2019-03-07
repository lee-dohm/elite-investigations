defmodule EliteInvestigations.EliteTest do
  use EliteInvestigations.DataCase

  alias EliteInvestigations.Elite

  describe "stories" do
    alias EliteInvestigations.Elite.Story

    @valid_attrs %{
      body: "some body",
      date: "3305-03-05",
      image: "some image",
      nid: 42,
      slug: "some slug",
      title: "some title"
    }

    @update_attrs %{
      body: "some updated body",
      date: "3304-01-23",
      image: "some updated image",
      nid: 43,
      slug: "some updated slug",
      title: "some updated title"
    }

    @invalid_attrs %{body: nil, date: nil, image: nil, nid: nil, slug: nil, title: nil}

    def story_fixture(attrs \\ %{}) do
      {:ok, story} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Elite.create_story()

      story
    end

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Elite.list_stories() == [story]
    end

    test "get_story!/1 returns the stories with given id" do
      story = story_fixture()
      assert Elite.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      assert {:ok, %Story{} = story} = Elite.create_story(@valid_attrs)
      assert story.body == "some body"
      assert story.date == "3305-03-05"
      assert story.image == "some image"
      assert story.nid == 42
      assert story.slug == "some slug"
      assert story.title == "some title"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Elite.create_story(@invalid_attrs)
    end

    test "update_stories/2 with valid data updates the stories" do
      story = story_fixture()
      assert {:ok, %Story{} = story} = Elite.update_story(story, @update_attrs)
      assert story.body == "some updated body"
      assert story.date == "3304-01-23"
      assert story.image == "some updated image"
      assert story.nid == 43
      assert story.slug == "some updated slug"
      assert story.title == "some updated title"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Elite.update_story(story, @invalid_attrs)
      assert story == Elite.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Elite.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Elite.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Elite.change_story(story)
    end
  end
end