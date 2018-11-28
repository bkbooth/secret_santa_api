defmodule SecretSantaWeb.Schema do
  use Absinthe.Schema

  import_types(SecretSantaWeb.Schema.AccountTypes)
  import_types(SecretSantaWeb.Schema.GiftTypes)

  alias SecretSanta.Accounts.User
  alias SecretSantaWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.list_users/3)
    end
  end

  mutation do
    @desc "Login user"
    field :login, type: :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.login/3)

      middleware(fn resolution, _ ->
        with %{value: %User{} = user} <- resolution do
          Map.update!(resolution, :context, fn context ->
            context
            |> Map.put(:login, true)
            |> Map.put(:user, user)
          end)
        end
      end)
    end

    @desc "Signup user"
    field :signup, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:phone_number, :string)

      resolve(&Resolvers.Accounts.signup/3)

      middleware(fn resolution, _ ->
        with %{value: %User{} = user} <- resolution do
          Map.update!(resolution, :context, fn context ->
            context
            |> Map.put(:login, true)
            |> Map.put(:user, user)
          end)
        end
      end)
    end
  end
end
