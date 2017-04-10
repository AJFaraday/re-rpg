module ActionModifiers

  class Add

    def initialize(percent:, add:, message: "Amount changed")
      @percent, @add, @message = percent, add, message
    end

    def change(amount)
      check = ChanceGenerator.percent(@percent)
      if check
        GameLogger.info(@message)
        (amount + @add)
      else
        amount
      end
    end

  end

end
