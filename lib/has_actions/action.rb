module HasActions

  class Action

    delegate :direction, :attribute, :amount,
             :message, :modifiers, to: :@template

    def initialize(template, source, target, options={})
      @template, @source, @target, @options = template, source, target, options
    end

    def perform
      x = run_modifiers(amount)
      log_action
      return fail_action if x == 0
      case direction
        when :increase
          @target.change(attribute, x)
        when :decrease
          @target.change(attribute, (x * -1))
        when :from
          @target.change(attribute, (x * -1))
          @source.change(attribute, x)
        when :to
          @source.change(attribute, (x * -1))
          @target.change(attribute, x)
      end
    end

    private

    def log_action
      if message
        GameLogger.info(
          message
            .gsub('SELF', @source.to_s)
            .gsub('TARGET', @target.to_s)
        )
      end
    end

    def fail_action
      GameLogger.info('it has no effect.')
    end

    def run_modifiers(amnt)
      modifiers.each do |modifier|
        amnt = modifier.change(amnt)
        return 0 if amnt == 0
      end
      amnt
    end

  end
end
