defmodule SecretSantaWeb.Schema.GiftTypes do
  use Absinthe.Schema.Notation

  # alias SecretSanta.Gifts.{Gifter, GiftGroup}
  # alias SecretSantaWeb.Resolvers.Gifts, as: Resolvers

  object :gift_group do
    field :id, non_null(:id)
    field :code, non_null(:string)
    field :name, non_null(:string)
    field :description, :string
    field :rules, list_of(:string)
    field :drawn, non_null(:boolean)
    field :owner, non_null(:user)
  end

  object :gifter do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, :string
    field :phone_number, :string
    field :exclusions, list_of(:gifter)
    field :gift_group, non_null(:gift_group)
    field :giftee, :gifter
    field :user, :user
  end

  object :gift_queries do
    # TODO
  end

  object :gift_mutations do
    # TODO
  end
end
