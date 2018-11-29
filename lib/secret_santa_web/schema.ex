defmodule SecretSantaWeb.Schema do
  use Absinthe.Schema

  import_types(SecretSantaWeb.Schema.AccountTypes)
  import_types(SecretSantaWeb.Schema.GiftTypes)

  query do
    import_fields(:account_queries)
    import_fields(:gift_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:gift_mutations)
  end
end
