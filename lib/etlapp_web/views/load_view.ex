defmodule EtlappWeb.EtlView do
  use EtlappWeb, :view

  def render("create.json", %{load: load}) do
    %{
      numbers: load
    }
  end

end
