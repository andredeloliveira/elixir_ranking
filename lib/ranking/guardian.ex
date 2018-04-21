defmodule Ranking.Guardian do
  use Guardian, otp_app: :ranking
  use Guardian.Permissions.Bitwise

  def subject_for_token(%{id: id}, claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_,_) do
    {:error, :no_resource_id}
  end

  def resource_from_claims(%{"sub" => sub}) do
    {:ok, Ranking.Accounts.get_user!(sub)}
  end

  def resource_from_claims(_claims) do
    {:error, :no_claims_sub}
  end

  def build_claims(claims, _resource, opts) do
    claims =
      claims
      |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))

    {:ok, claims}
  end
end