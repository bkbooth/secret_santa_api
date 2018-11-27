defmodule SecretSantaWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias SecretSanta.Accounts.{Guardian, User}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    case Map.get(conn, :req_cookies) do
      %{"auth_token" => auth_token} -> %{auth_token: auth_token}
      _ -> %{auth_token: nil}
    end
  end

  def put_token_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    with true <- blueprint.execution.context[:login],
         %User{} = user <- blueprint.execution.context[:user],
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      put_resp_cookie(conn, "auth_token", token,
        http_only: true,
        # 30 days token
        max_age: 60 * 60 * 24 * 30
      )
    else
      _ -> conn
    end
  end

  def put_token_before_send(conn, _), do: conn
end
