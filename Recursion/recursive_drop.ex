defmodule ListDrop do
  def falls(list) do
    falls(list,[])
  end

  def falls([], results) do
    Enum.reverse(results)
  end

  def falls([h|t], results) do
    falls(t,[Drop.fall_velocity(h)|results]) #we storage in reverse order
  end
end

