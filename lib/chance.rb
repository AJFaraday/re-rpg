class Chance

  class PseudoRandom
    def initialize(seed = 0)
      @i = seed
    end
    def rand(arg)
      @i += 1
      @i % arg
    end
  end

  def initialize(seed=Time.now.to_i)
    #@generator = Random.new(seed)
    @generator = PseudoRandom.new
  end

  def percent(target)
    proportion(target, 100)
  end

  # x in y chance of being true
  def proportion(target, amount)
    roll_die(amount) <= target
  end

  def roll_die(number)
    (@generator.rand(number) + 1)
  end

  # roll a bag of dice
  #
  def roll_bag(dice=[])
    raise "No dice in bag" if dice.empty?
    DieBag.new(dice, self)
  end

  class DieBag

    attr_reader :results

    def initialize(dice, chance_generator)
      @results = dice.collect { |die| chance_generator.roll_die(die) }
    end

    def [](index)
      @results[index]
    end

    def each(&block)
      @results.each(&block)
    end

    def length
      @results.length
    end

    def sum
      @results.inject(0, &:+)
    end

  end

end

