defmodule SecretSantaWeb.Resolvers.Accounts do
  alias SecretSanta.Accounts

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def login(_parent, %{email: email, password: password}, _resolution) do
    Accounts.authenticate_by_email_and_password(email, password)
  end

  def signup(_parent, args, _resolution) do
    Accounts.create_user(args)
  end
end
