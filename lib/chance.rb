class Chance

  def initialize(seed=Time.now.to_i)
    @generator = Random.new(seed)
  end

  def percent(amount)
    (@generator.rand(100) + 1) <= amount
  end

  # x in y chance of being true
  def proportion(x, y)
    @generator.rand(y) <= x
  end

end

