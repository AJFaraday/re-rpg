# The class name is a lie
# This is an increment, not a random.
class IncrementRandom

  def initialize(seed = 0)
    @i = seed
  end

  def rand(arg)
    @i += 1
    @i % arg
  end

end
