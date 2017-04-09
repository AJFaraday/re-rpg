module ActionPreconditions

  class Critical

    def initialize(percent:, multiplier:)
      @critical_percent = percent
      @multiplier = multiplier
    end

    def change(amount)
      check = ChanceGenerator.percent(@critical_percent)
      check ? (amount * @multiplier) : amount
    end

  end

end