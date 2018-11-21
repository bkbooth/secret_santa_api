defmodule SecretSantaWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :phone_number, :string
    field :gift_groups, list_of(:gift_group)
  end
end
