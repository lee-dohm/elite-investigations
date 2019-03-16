# Script to manually trim excess whitespace from all fields in the `stories` table.
#
# Execute in production with: `heroku run "POOL_SIZE=2 mix run priv/repo/trim_story_strings.exs"`

alias EliteInvestigations.Elite

Elite.list_stories()
|> Enum.each(fn story ->
     Elite.update_story(
       story,
       %{
         body: String.trim(story.body),
         image: String.trim(story.image),
         slug: String.trim(story.slug),
         title: String.trim(story.title)
       }
     )
   end)
