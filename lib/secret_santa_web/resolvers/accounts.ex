defmodule SecretSantaWeb.Resolvers.Accounts do
  alias SecretSanta.Accounts

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def login(_parent, %{email: email, password: password}, _resolution) do
    case Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, _token, %{"sub" => user_id}} ->
        # TODO: login the user via session/cookie
        {:ok, Accounts.get_user!(user_id)}

      _ ->
        {:error, :unprocessable_entity}
    end
  end
end
