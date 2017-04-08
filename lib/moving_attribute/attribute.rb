module MovingAttribute

  class Attribute

    attr_reader :maximum
    attr_reader :value

    def initialize(initial, maximum)
      @value = initial
      @maximum = maximum
    end

    def change(amount)
      @value += amount
      fill if @value > @maximum
      empty if @value < 0
      @value = @value.to_i
    end

    def fill
      @value = @maximum
    end

    def empty
      @value = 0
    end

  end

end