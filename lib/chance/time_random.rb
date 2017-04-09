# The class name is a lie
# This will decide rolls based on the current microsecond
class TimeRandom

  def initialize(seed = 0)

  end

  def rand(arg)
    i = (Time.now.to_f * 1000000).to_i
    i % arg
  end

end
