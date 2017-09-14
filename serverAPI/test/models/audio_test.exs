defmodule ServerAPI.AudioTest do
  use ServerAPI.ModelCase

  alias ServerAPI.Audio

  @valid_attrs %{artist: "some content", filename: "some content", genre: "some content", path: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Audio.changeset(%Audio{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Audio.changeset(%Audio{}, @invalid_attrs)
    refute changeset.valid?
  end
end
