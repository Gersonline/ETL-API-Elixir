defmodule Etlapp.Load do

  defmodule Loop do
    def print_multiple_times(orderlist, n) when n < 1 do
      IO.inspect(Enum.sort(orderlist))
    end

    def print_multiple_times(orderlist, n) do
      IO.inspect(orderlist)

      url = "http://challenge.dienekes.com.br/api/numbers?page=" <> Integer.to_string(n)
      IO.inspect(url)
      response = HTTPotion.get!(url)
      result = Poison.Parser.parse response.body

      #IO.inspect(result)
      list = elem(result, 1)
      #numbers = Enum.at(list, 0)
      listnumbers = list["numbers"]
      newlist = listnumbers
      IO.inspect(newlist)

      cond do
        newlist != nil ->
          #Process.sleep(1000)
          print_multiple_times(orderlist ++ Enum.sort(newlist), n + 1)
        newlist == nil ->
          print_multiple_times(orderlist, 0)
      end

    end
 end

  def create("ok") do

    url = "http://challenge.dienekes.com.br/api/numbers?page=1"

    response = HTTPotion.get!(url)
    result = Poison.Parser.parse response.body
    list = elem(result, 1)
    #numbers = Enum.at(list, 0)
    listnumbers = list["numbers"]
    orderlist = listnumbers

    newlist = Loop.print_multiple_times(Enum.sort(orderlist), 1)
    IO.inspect(newlist)

    #for n <- listnumbers, times <- length(listnumbers)..n, do: IO.inspect(listnumbers)




'''
    #req1 = Enum.at(req, 2)
    IO.inspect("============================BODY============")
    IO.inspect(response)
    IO.inspect(response.body)
    IO.inspect(result)
    IO.inspect(list)
    IO.inspect("============================numbers============")
   # IO.inspect(numbers)
    IO.inspect(listnumbers)
    IO.inspect(orderlist)
'''
    {:ok, %{ordernumbers: newlist}}
  end

  def create("error") do
    {:ok, "Erro na ordenação"}
  end
end
