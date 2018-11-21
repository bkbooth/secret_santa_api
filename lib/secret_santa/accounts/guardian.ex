defmodule SecretSanta.Accounts.Guardian do
  use Guardian, otp_app: :secret_santa

  alias SecretSanta.Accounts
  alias SecretSanta.Accounts.User

  def subject_for_token(user, _claims) do
    {:ok, user.id}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :user_not_found}
      %User{} = user -> {:ok, user}
    end
  end
end
