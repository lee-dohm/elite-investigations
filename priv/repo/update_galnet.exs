Application.ensure_all_started(:inets)
Application.ensure_all_started(:ssl)

alias EliteInvestigations.Galnet

Galnet.update()
