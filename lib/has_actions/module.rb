module HasActions

  def self.included(base)
    base.send :extend, ClassMethods
    base.class_variable_set(:@@action_templates, {})

    base.class_eval do
      original_method = instance_method(:initialize)
      define_method(:initialize) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        @action_templates = {}
        base.class_variable_get(:@@action_templates).each do |name, action_template|
          @action_templates[name] = action_template.dup
        end
      end
    end
  end

  module ClassMethods
    def has_actions
      send :include, InstanceMethods
    end

    # TODO type, to affect health
    def action_template(name, attribute, direction, amount, message:, modifiers: [])
      class_variable_get(:@@action_templates)[name.to_sym] = HasActions::ActionTemplate.new(
        attribute,
        direction,
        amount,
        message: message,
        modifiers: modifiers
      )
    end

  end

  module InstanceMethods

    def actions
      @action_templates.keys
    end

    def set_action_attribute(action_name, attribute, value)
      get_action_template(action_name).set(attribute, value)
    end

    def action(action_name, target, options={})
      template = get_action_template(action_name)
      template.get_action(self, target, options).perform
    end

    private

    def get_action_template(action_name)
      action = @action_templates[action_name.to_sym]
      raise UnknownActionError.new(action_name) unless action.is_a?(ActionTemplate)
      action
    end

  end


  class UnknownActionError < StandardError
    def initialize(action_name)
      @action_name = action_name
    end

    def message
      "Entity does not have an action named \"#{@action_name}\""
    end
  end

end