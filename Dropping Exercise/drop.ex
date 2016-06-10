defmodule Drop do

	@moduledoc """
	Functions calculating velocities achieved by objects dropped in a vacuum.
	"""

	@doc """
	Calculates the velocity of an object falling on Earth
	as if it were in a vacuum (no air resistance).  The distance is
	the height from which the object falls, specified in meters,
	and the function returns a velocity in meters per second.
	"""
	import :math, only: [sqrt: 1]

	def fall_velocity_manual(distance, gravity \\ 9.8) do		
		sqrt(2 * gravity * distance)
	end

	def cuadratic_fall_velocity(distance) do
		fun = &fall_velocity_manual/1
		fun.(distance) * fun.(distance)
	end


	def fall_velocity(where) do
		fall_velocity(elem(where,0), elem(where,1))
	end

	def fall_velocity(planemo, distance) when distance >=0 do
		#Pattern matching
		gravity = case planemo do
			:earth -> 9.8
			:moon -> 1.6
			:mars -> 3.71
			_ -> 0
		end

		velocity = sqrt(2 * gravity * distance)
		
		if velocity > 20 do
			IO.puts("Look out below!")
		else
			IO.puts("Reasonable...")
		end

		cond do
			velocity == 0 -> :stable
			velocity < 5 -> :slow
			velocity >= 5 and velocity < 10 -> :moving
			velocity >= 10 and velocity < 20 -> :fast
			velocity >= 20 -> :speedy
		end
	end
end

