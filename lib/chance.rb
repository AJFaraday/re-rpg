class Chance

  include Singleton

  def self.percent(amount)
    (rand(100) + 1) <= amount
  end

  # x in y chance of being true
  def self.proportion(x, y)
    rand(y) <= x
  end

end

