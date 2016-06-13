#Higher-order Functions
defmodule Hof do
  def tripler(value, function) do
    3 * function.(value)
  end
end

defmodule Order_Functions do
  #print by default
  def each(list, function \\ fn(value) -> IO.puts("#{value}") end) do
    Enum.each(list, function)
  end

  def map(list \\ (1..10)) do
    square = &(&1*&1)
    #map and print
    each(Enum.map(list, square))
  end

  @doc """
  list comprehension cons:
  - the only type of result they can return is a list
  - lack of support for accumulators
  - dont let you suspend proccessing in certain conditions
  """

  def listComprehension(list \\ (1..10)) do
    #square(map)
    newOne = for value <- list, do: value * value
    #filter
    newOne = for value <-newOne, value>25 , do: value
    #print all(each)
    each(newOne)
  end

  def filter(list, function \\ &(&1>25)) do
    Enum.filter(list, function)
  end

  def testList(list, function \\ &(&1>10)) do
    IO.inspect(Enum.any?(list, function))
    IO.inspect(Enum.all?(list, function))
  end

  def partition(list, function \\ &(&1>10)) do
    {list1, list2} = Enum.partition(list, function)
    each(list1)
    each(list2)
  end

  def dropWhile(list \\ [1,2,4,8,4,2,1]) do
    Enum.drop_while(list, &(&1<4))
  end

  def takeWhile(list \\ [1,2,4,8,4,2,1]) do
    Enum.take_while(list, &(&1<4))
  end

  def fold(list, function \\ &(&1/&2))do
    #dolfl (head to tail)
    IO.inspect(List.foldl(list, 1, function))
    #foldr (tail to head)
    IO.inspect(List.foldr(list, 1, function))
  end
end