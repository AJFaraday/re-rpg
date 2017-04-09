module ActionPreconditions

  class Critical

    def initialize(percent:, multiplier:, message: "Amount multiplied")
      @percent, @multiplier, @message = percent, multiplier, message
    end

    def change(amount)
      check = ChanceGenerator.percent(@percent)
      if check
        GameLogger.info(@message)
        (amount * @multiplier)
      else
        amount
      end
    end

  end

end