module ActionPreconditions

  class Hit

    def initialize(percent:)
      @hit_percent = percent
    end

    def change(amount)
      check = ChanceGenerator.percent(@hit_percent)
      check ? amount : 0
    end

  end

end