class AlwaysSameRandom

  def initialize(seed = 100)
    @n = seed
  end

  def rand(arg)
    @n % arg
  end

end