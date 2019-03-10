defmodule EliteInvestigations.Ecto.GalnetDateTest do
  use ExUnit.Case

  alias EliteInvestigations.Ecto.GalnetDate

  setup do
    naive_datetime = ~N[3304-01-23 00:00:00]
    datetime = DateTime.from_naive!(naive_datetime, "Etc/UTC")

    {:ok, datetime: datetime, galnet_date: "23 JAN 3304", naive_datetime: naive_datetime}
  end

  describe "casting" do
    test "a binary returns the binary", context do
      {:ok, return_text} = GalnetDate.cast(context.galnet_date)

      assert return_text == context.galnet_date
    end

    test "a DateTime returns the equivalent binary", context do
      {:ok, return_text} = GalnetDate.cast(context.datetime)

      assert return_text == context.galnet_date
    end

    test "a NaiveDateTime returns the equivalent binary", context do
      {:ok, return_text} = GalnetDate.cast(context.naive_datetime)

      assert return_text == context.galnet_date
    end

    test "an invalid data type returns an error" do
      assert :error == GalnetDate.cast(5)
    end
  end

  describe "loading" do
    test "a DateTime returns the equivalent binary", context do
      {:ok, return_text} = GalnetDate.load(context.datetime)

      assert return_text == context.galnet_date
    end

    test "a NaiveDateTime returns the equivalent binary", context do
      {:ok, return_text} = GalnetDate.load(context.naive_datetime)

      assert return_text == context.galnet_date
    end

    test "an invalid data type returns an error" do
      assert :error == GalnetDate.load(5)
    end
  end

  describe "dumping" do
    test "a binary returns the equivalent NaiveDateTime", context do
      {:ok, return_datetime} = GalnetDate.dump(context.galnet_date)

      assert return_datetime == context.naive_datetime
    end

    test "an invalid data type returns an error" do
      assert :error == GalnetDate.dump(5)
    end
  end
end
