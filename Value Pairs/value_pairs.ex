#Name-Value-Pairs

defmodule Lists do
	def planemo do
		[{:earth, 9.8}, {:moon, 1.6}, {:mars, 3.71}]		
	end

	def atomic_weights do
		[hydrogen: 1.008, carbon: 12.011, sodium: 22.99]
	end

	def ages do
		[david: 59, simon: 40, cathy: 28, simon: 30]
	end
end

# Keywoard lists
# Sometimes you need to process lists of tuples containing two elements that
# can be considered as a “key and value” pair, where the key is an atom.
#the same operations are available for list of tuples with multiple keys

defmodule KeywordList do
	@doc """
	use Keyboard.get/3 to retrieve the first value in the list  with a given key
	the optional third argument provides a default value if the key not found
	get/2 will retireve all the values (maybe there are duplicates)
	"""
	def get() do
		IO.inspect(Keyword.get(Lists.atomic_weights, :hydrogen))
		IO.inspect(Keyword.get(Lists.atomic_weights, :neon))
		IO.inspect(Keyword.get(Lists.atomic_weights, :carbon, 0))
		IO.inspect(Keyword.get(Lists.atomic_weights, :neon, 0))		
	end

	@doc """
	will raise an error if the key is not found		
	"""
	def fetch() do
		IO.inspect(Keyword.fetch!(Lists.atomic_weights, :hydrogen))
		IO.inspect(Keyword.fetch!(Lists.atomic_weights, :neon))
	end

	def hasKey() do
		IO.inspect(Keyword.has_key?(Lists.atomic_weights, :carbon))
		IO.inspect(Keyword.has_key?(Lists.atomic_weights, :neon))
	end

	@doc """
	if the key already exists, its value remains unchanges
	"""
	def putNew() do	
		IO.inspect(Keyword.put_new(Lists.atomic_weights, :helium, 4.0026))
	end

	@doc """
	To replace a value, use Keyword.put/3 If the key doesn’t exist, it will be created.
	If it does exist, all entries for that key will be removed and the new entry added
	"""
	def put() do		
		#new entry
		IO.inspect(Keyword.put(Lists.ages, :chung, 19))
		#update enty
		IO.inspect(Keyword.put(Lists.ages, :chung, 25))
	end

	def delete() do
		IO.inspect(Keyword.delete(Lists.ages, :chung))
	end
end


defmodule HashDictionary do
	@doc """
	used when the key will be unique
	use the same functions from keyword list (instead of Keyword we use Dict)
	"""
	def planemo() do
		Enum.into([earth: 9.8, moon: 1.6, mars: 3.71], HashDict.new())
	end
end

defmodule Maps do
	@doc """
	Is the same to keywords but the key could be any kind of value
	"""
	def planemo() do
		number_map = %{2 => "two", 3 => "three"}
		planemomap = %{:earth => 9.8, :moon => 1.6, :mars => 3.71}
	end

	def update() do
		IO.inspect(%{Maps.planemo | earth: 12, mars: 4})
		IO.inspect(Dict.put_new(Maps.planemo,:jupiter, 23.1))
	end

	def read() do
		%{earth: earth_gravity} = planemo
		earth_gravity
	end
end


# Structs
# based on maps and keeps track of the key names and checks invalid keys
# they always are declared in a new module (file)
# creates as maps (var1 = %StructName{})
# let us attach behaviors with proptocols (not only available in structs)
	
# defining a protocol for valid structures
# its another module (tfile)
defprotocol Valid do
  @doc "Returns true if data is considered nominally valid"
  def valid?(data)
end

defmodule Planemo do
	defstruct name: :nil, gravity: 0, diameter: 0, distance_from_sun: 0
	
	defimpl Valid, for: Planemo do
		def valid?(p) do
			p.gravity >= 0 && p.diameter >= 0 &&
			p.distance_from_sun >= 0
		end
	end
end

defmodule Tower do
	defstruct location: "", height: 20, planemo: :earth, name: ""
	defimpl Valid, for: Tower do
		def valid?(%Tower{height: h, planemo: p}) do
			h >= 0 && p != nil
		end
	end
end




defmodule StructDrop do

  def fall_velocity(t) do
    fall_velocity(t.planemo, t.height)
  end
  
  def fall_velocity(%Tower{planemo: planemo, height: distance}) do
    fall_velocity(planemo, distance)
  end

  def fall_velocity(:earth, distance) when distance >= 0 do
    :math.sqrt(2 * 9.8 * distance)
  end

  def fall_velocity(:moon, distance) when distance >= 0 do
    :math.sqrt(2 * 1.6 * distance)
  end

  def fall_velocity(:mars, distance) when distance >= 0 do
    :math.sqrt(2 * 3.71 * distance)
  end

end