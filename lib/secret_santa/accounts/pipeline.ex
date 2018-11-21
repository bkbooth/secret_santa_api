defmodule SecretSanta.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :secret_santa,
    module: SecretSanta.Accounts.Guardian,
    error_handler: SecretSanta.Accounts.ErrorHandler

  alias Guardian.Plug

  plug Plug.VerifyCookie
  plug Plug.LoadResource, allow_blank: true
end
