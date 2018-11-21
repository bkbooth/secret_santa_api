defmodule SecretSantaWeb.Schema do
  use Absinthe.Schema

  import_types(SecretSantaWeb.Schema.AccountTypes)
  import_types(SecretSantaWeb.Schema.GiftTypes)

  alias SecretSantaWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.list_users/3)
    end
  end
end
