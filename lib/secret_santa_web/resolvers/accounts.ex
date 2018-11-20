defmodule SecretSantaWeb.Resolvers.Accounts do
  def list_users(_parent, _args, _resolution) do
    {:ok, SecretSanta.Accounts.list_users()}
  end
end
