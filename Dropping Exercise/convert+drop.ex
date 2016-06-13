#convenience functions!
defmodule Convert+Drop do
  import Convert
  import Drop

  def height_to_mph(meters) do #takes meters, returns mph
      fall_velocity(meters) |> mps_to_mph
  end
end
