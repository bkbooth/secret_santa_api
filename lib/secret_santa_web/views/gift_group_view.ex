defmodule SecretSantaWeb.GiftGroupView do
  use SecretSantaWeb, :view
  alias SecretSantaWeb.GiftGroupView

  def render("index.json", %{gift_groups: gift_groups}) do
    %{data: render_many(gift_groups, GiftGroupView, "gift_group.json")}
  end

  def render("show.json", %{gift_group: gift_group}) do
    %{data: render_one(gift_group, GiftGroupView, "gift_group.json")}
  end

  def render("gift_group.json", %{gift_group: gift_group}) do
    %{
      id: gift_group.id,
      code: gift_group.code,
      name: gift_group.name,
      description: gift_group.description,
      rules: gift_group.rules
    }
  end
end
