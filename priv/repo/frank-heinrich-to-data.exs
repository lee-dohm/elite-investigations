#!/usr/bin/env elixir

require Logger

slugify =
  fn title ->
    title
    |> String.downcase()
    |> String.replace(~r{\W+}u, "-")
    |> String.trim("-")
  end

records =
  __DIR__
  |> Path.join("ed-frank-heinrich-net.html")
  |> File.read!()
  |> String.split("\n")
  |> Enum.map(&String.trim/1)
  |> Enum.reduce({[], []}, fn line, acc ->
       {current, records} = acc

       # cond do
       #   String.match?(line, ~r{^<h2>(.*)</h2>$}) -> {[line], records}
       #   String.match?(line, ~r{^<p>(.*)</a>$}) -> {current, records}
       #   String.match?(line, ~r{^</p>$}) -> {[], [Enum.reverse(current) | records]}
       #   true -> {[line | current], records}
       # end
       cond do
         String.match?(line, ~r{^<h2>(.*)</h2>$}) -> {[line], [Enum.reverse(current) | records]}
         String.match?(line, ~r{^<p>(.*)</a>$}) -> {current, records}
         true -> {[line | current], records}
       end
     end)
  |> elem(1)
  |> Enum.reject(fn lines -> lines === [] end)
  |> Enum.map(fn lines ->
       [head_line | body_lines] = lines
       [_, date, title] = Regex.run(~r">(\d+ [A-Z]+ \d+) – (.+)</span></h2>$", head_line)

       trimmed_lines = Enum.map(body_lines, fn line -> String.slice(line, 7..-1) end)
       body = "<p>#{Enum.join(trimmed_lines, "<br />\n")}</p>"

       %{
         body: body,
         date: date,
         from_frontier: false,
         image: "NewsImage",
         slug: slugify.(title),
         title: title
       }
     end)
  |> Enum.with_index(1)
  |> Enum.map(fn {map, index} ->
       Map.put(map, :nid, index)
     end)

json_file = Path.join(__DIR__, "frank-heinrich-data.json")
File.write!(json_file, Jason.encode!(records, pretty: true))
