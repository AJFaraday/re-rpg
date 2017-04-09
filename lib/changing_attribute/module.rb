module ChangingAttribute

  def self.included(base)
    base.class_variable_set(:@@moving_attributes, {})
    base.send :extend, ClassMethods

    base.class_eval do
      original_method = instance_method(:initialize)
      define_method(:initialize) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        @moving_attributes = {}
        base.class_variable_get(:@@moving_attributes).each do |name, template_attribute|
          @moving_attributes[name] = template_attribute.dup
        end
      end
    end
  end

  module ClassMethods
    def moving_attribute(name, initial, maximum)
      send :include, InstanceMethods
      self.class_variable_get(:@@moving_attributes)[name.to_sym] = Attribute.new(initial, maximum)
    end
  end

  module InstanceMethods

    def change(attr, amount)
      get_attribute(attr).change(amount)
    end

    [:get, :maximum, :fill, :empty].each do |meth|
      define_method(meth) do |attribute_name|
        get_attribute(attribute_name).public_send(meth)
      end
    end

    private

    def get_attribute(attribute_name)
      attribute = @moving_attributes[attribute_name.to_sym]
      raise UnknownAtributeError.new(attribute_name) unless attribute.is_a?(Attribute)
      attribute
    end

  end

  class UnknownAtributeError < StandardError
    def initialize(attribute_name)
      @attribute_name = attribute_name
    end

    def message
      "Entity does not have an attribute named \"#{@attribute_name}\""
    end
  end

end