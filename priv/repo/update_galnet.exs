# Script to manually update the Galnet stories
#
# Execute in production with: `heroku run "POOL_SIZE=2 mix run priv/repo/update_galnet.exs"`

Application.ensure_all_started(:inets)
Application.ensure_all_started(:ssl)

alias EliteInvestigations.Galnet

Galnet.update()
