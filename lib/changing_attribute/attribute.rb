module ChangingAttribute

  class Attribute

    attr_reader :maximum

    def initialize(initial, maximum)
      @value = initial
      @maximum = maximum
    end

    def get
      @value
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