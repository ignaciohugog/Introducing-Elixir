#to watch processes: :observer.start
#Process.unlink
#Process.monitor
#Process.exit
defmodule Drop do
  def drop do
    receive do
      {from, planemo, distance} ->
        send(from, {planemo, distance, fall_velocity(planemo, distance)})
        drop()
    end
  end

  defp fall_velocity(:earth, distance) when distance >= 0 do
    :math.sqrt(2 * 9.8 * distance)
  end

  defp fall_velocity(:moon, distance) when distance >= 0 do
    :math.sqrt(2 * 1.6 * distance)
  end

  defp fall_velocity(:mars, distance) when distance >= 0 do
    :math.sqrt(2 * 3.71 * distance)
  end
end

defmodule MphDrop do
  #when a process is linked with other and an error raise, it will kill
  #all the linked process
  #for more control we can raise this error:

  def mph_drop do
    Process.flag(:trap_exit, true) #trap an error
    drop_pid = spawn_link(Drop, :drop, [])
    convert(drop_pid)
  end

  def convert(drop_pid) do
    receive do
      {planemo, distance} ->
        send(drop_pid, {self(), planemo, distance})
        convert(drop_pid)
        #traps an error -> in this case th Drop process is never created because
        #there is no match for the current argument but we can create a new one:
      {:EXIT, pid, reason} ->
        IO.puts("FAILURE:#{inspect(pid)} #{inspect(reason)}")
        new_drop_pid = spawn_link(Drop, :drop, [])
        convert(new_drop_pid)
      {planemo, distance, velocity} ->
        mph_velocity = 2.23693629 * velocity
        IO.write("On #{planemo}, a fall of #{distance} meters")
        IO.puts("yields a velocity of #{mph_velocity} mph.")
        convert(drop_pid)
    end
  end
end
