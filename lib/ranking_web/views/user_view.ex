defmodule RankingWeb.UserView do
  use RankingWeb, :view
  alias RankingWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      hashed_password: user.hashed_password,
      email: user.email,
      permissions: user.permissions}
  end
end
