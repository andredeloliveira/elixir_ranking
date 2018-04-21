defmodule Ranking.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ranking.Repo

  alias Ranking.Accounts.User


  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_username_and_password(nil, password), do: {:error, :invalid}
  def get_user_by_username_and_password(username, nil), do: {:error, :invalid}

  def get_user_by_username_and_password(username, password) do
    with  %User{} = user <- Repo.get_by(User, username: String.downcase(username)),
          true <- Comeonin.Bcrypt.checkpw(password, user.hashed_password) do
      {:ok, user}
    else
      _ ->
        # Help to mitigate timing attacks
        Comeonin.Bcrypt.dummy_checkpw
        {:error, :unauthorised}
    end
  end
end
