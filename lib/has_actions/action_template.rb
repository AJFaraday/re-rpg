module HasActions

  class ActionTemplate

    attr_reader :attribute, :direction, :amount, :message, :modifiers

    OPTIONS = {
      direction: [:increase, :decrease, :to, :from]
    }

    def initialize(attribute, direction, amount, message: nil, modifiers: [])
      @attribute, @direction, @amount = attribute, direction, amount
      @message = message
      @modifiers = build_modifiers(modifiers)
    end

    def set(attribute, value)
      if OPTIONS[attribute.to_sym] && OPTIONS[attribute.to_sym].include?(value)
        raise "Invalid attribute for #{attribute}: '#{value}'"
      end
      instance_variable_set("@#{attribute}", value)
    end

    def get_action(source, target, options={})
      Action.new(self, source, target, options)
    end

    def add_modifier(modifier_spec)
      @modifiers << build_modifier(modifier_spec)
    end

    def copy
      duplicate = self.dup
      duplicate.instance_variable_set(:@modifiers, self.modifiers.map(&:dup))
      duplicate
    end

    private


    def build_modifiers(modifiers)
      modifiers.collect do |modifier_spec|
        build_modifier(modifier_spec)
      end
    end

    def build_modifier(modifier_spec)
      kls = ActionModifiers.const_get(modifier_spec.delete(:type))
      kls.new(modifier_spec)
    end

  end

end
