module ActionPreconditions

  class Nullify

    def initialize(percent:, message: "Amount nullified")
      @percent, @message = percent, message
    end

    def change(amount)
      check = ChanceGenerator.percent(@percent)
      if check
        GameLogger.info(@message)
        0
      else
        amount
      end
    end

  end

end