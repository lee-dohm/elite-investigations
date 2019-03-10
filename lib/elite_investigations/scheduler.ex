defmodule EliteInvestigations.Scheduler do
  @moduledoc """
  Scheduler to handle running of periodic tasks.

  See: `Quantum`
  """
  use Quantum.Scheduler, otp_app: :elite_investigations
end
