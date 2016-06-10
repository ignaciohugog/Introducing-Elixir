#use after to stop waiting a given amount of time 
#Process.whereis (return the pid already register)
#Process.register (register a pid with an atom)
#Process.unregister !register
#Process.spawn (create a new process)
#Process.registered (show the already registered process)

defmodule Basic_processes do
	def report(count) do
		receive do
			msg->IO.puts("Received #{msg} and count is #{count}")
			report(count + 1)
		#after 100_000 -> IO.puts("I'm done, fuck u!")					
		end
	end

	def another() do
		receive do
			msg -> IO.puts("another one is listening #{msg}")
			another()
		end
	end
end