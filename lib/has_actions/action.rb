module HasActions

  class Action

    delegate :direction, :attribute, :amount,
             :message, :modifiers, to: :@template

    def initialize(template, source, target, options={})
      @template, @source, @target, @options = template, source, target, options
    end

    def perform
      log_action
      x = run_modifiers(amount)
      if x == 0
        return fail_action
      end
      case direction
        when :increase
          @source.change(attribute, x)
        when :decrease
          @source.change(attribute, (x * -1))
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
          message.gsub('SELF', @source.to_s).gsub('TARGET', @target.to_s)
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
