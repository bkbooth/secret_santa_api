defmodule SecretSantaWeb.Schema.GiftTypes do
  use Absinthe.Schema.Notation

  object :gift_group do
    field :id, non_null(:id)
    field :code, non_null(:string)
    field :name, non_null(:string)
    field :description, :string
    field :rules, list_of(:string)
    field :owner, non_null(:user)
  end

  object :gifter do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, :string
    field :phone_number, :string
    field :gift_group, non_null(:gift_group)
    field :giftee, :gifter
    field :user, :user
  end
end
