defmodule SecretSantaWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias SecretSanta.Accounts.User
  alias SecretSantaWeb.Resolvers.Accounts, as: Resolvers

  import_types(Kronky.ValidationMessageTypes)

  object :user do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :phone_number, :string
    field :gift_groups, list_of(:gift_group)
  end

  input_object :login_params do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  input_object :signup_params do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :phone_number, :string
  end

  object :account_queries do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.list_users/3)
    end
  end

  payload_object(:user_payload, :user)

  object :account_mutations do
    @desc "Login user"
    field :login, type: :user_payload do
      arg(:credentials, :login_params)
      resolve(&Resolvers.login/3)
      # middleware(&build_payload/2)

      # middleware(fn resolution, _ ->
      #   resolution |> Map.get(:value) |> IO.inspect()

      #   with %{value: %Kronky.Payload{result: %User{} = user}} <- resolution do
      #     Map.update!(resolution, :context, fn context ->
      #       context
      #       |> Map.put(:login, true)
      #       |> Map.put(:user, user)
      #     end)
      #   end
      # end)
    end

    @desc "Signup user"
    field :signup, type: :user_payload do
      arg(:user, :signup_params)
      resolve(&Resolvers.signup/3)

      middleware(fn resolution, _ ->
        with %{errors: %Ecto.Changeset{} = changeset} <- resolution do
          IO.inspect(changeset)
          # result = convert_to_payload(changeset)
          Absinthe.Resolution.put_result(resolution, {:ok, nil})
        end
      end)

      # middleware(&build_payload/2)

      # middleware(fn resolution, _ ->
      #   resolution |> Map.get(:value) |> IO.inspect()

      #   with %{value: %Kronky.Payload{result: %User{} = user}} <- resolution do
      #     Map.update!(resolution, :context, fn context ->
      #       context
      #       |> Map.put(:login, true)
      #       |> Map.put(:user, user)
      #     end)
      #   end
      # end)
    end
  end
end
