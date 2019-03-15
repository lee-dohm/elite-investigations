import_file_if_available "~/.iex.exs"

use Phoenix.HTML

import Ecto.Query
import Phoenix.HTML.Safe, only: [to_iodata: 1]

alias EliteInvestigations.Elite
alias EliteInvestigations.Elite.Story
alias EliteInvestigations.Galnet
alias EliteInvestigations.Repo
