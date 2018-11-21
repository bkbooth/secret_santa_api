# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SecretSanta.Repo.insert!(%SecretSanta.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SecretSanta.{Accounts, Gifts}

# Mario's gift group

{:ok, mario} =
  Accounts.create_user(%{
    name: "Mario",
    email: "mario@example.com",
    password: "mario123",
    phone_number: "0123456789"
  })

{:ok, mario_gift_group} =
  Gifts.create_gift_group(mario, %{
    name: "Mario's Gift Group",
    description: "A gift group for all of Mario's best friends",
    rules: ["Limit of $20", "Give the best gift to Mario", "Give the worst gift to Bowser"]
  })

{:ok, _} =
  Gifts.create_gifter(mario_gift_group, %{
    name: "Mario",
    email: "mario@example.com",
    user_id: mario.id
  })

{:ok, _} =
  Gifts.create_gifter(mario_gift_group, %{
    name: "Luigi",
    email: "luigi@example.com"
  })

{:ok, _} =
  Gifts.create_gifter(mario_gift_group, %{
    name: "Peach",
    email: "peach@example.com"
  })

{:ok, _} =
  Gifts.create_gifter(mario_gift_group, %{
    name: "Bowser",
    email: "bowser@example.com"
  })

# Luigi's gift group

{:ok, luigi} =
  Accounts.create_user(%{
    name: "Luigi",
    email: "luigi@example.com",
    password: "luigi123",
    phone_number: "0987654321"
  })

{:ok, luigi_gift_group} =
  Gifts.create_gift_group(luigi, %{
    name: "Luigi's Gift Group",
    description: "A gift group for all of Luigi's best friends",
    rules: ["Limit of $30", "Give something green"]
  })

{:ok, _} =
  Gifts.create_gifter(luigi_gift_group, %{
    name: "Luigi",
    email: "luigi@example.com",
    user_id: luigi.id
  })

{:ok, _} =
  Gifts.create_gifter(luigi_gift_group, %{
    name: "Mario",
    email: "mario@example.com"
  })

{:ok, _} =
  Gifts.create_gifter(luigi_gift_group, %{
    name: "Yoshi",
    email: "yoshi@example.com"
  })

{:ok, _} =
  Gifts.create_gifter(luigi_gift_group, %{
    name: "Toad",
    email: "toad@example.com"
  })
