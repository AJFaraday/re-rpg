module ChangingAttribute

  def self.included(base)
    base.class_variable_set(:@@changing_attributes, {})
    base.send :extend, ClassMethods

    base.class_eval do
      original_method = instance_method(:initialize)
      define_method(:initialize) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        @changing_attributes = {}
        base.class_variable_get(:@@changing_attributes).each do |name, template_attribute|
          @changing_attributes[name] = template_attribute.dup
        end
      end
    end
  end

  module ClassMethods
    def changing_attribute(name, initial:, maximum:)
      send :include, InstanceMethods
      self.class_variable_get(:@@changing_attributes)[name.to_sym] = Attribute.new(initial, maximum)
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
      attribute = @changing_attributes[attribute_name.to_sym]
      raise UnknownAttributeError.new(attribute_name) unless attribute.is_a?(Attribute)
      attribute
    end

  end

  class UnknownAttributeError < StandardError
    def initialize(attribute_name)
      @attribute_name = attribute_name
    end

    def message
      "Entity does not have an attribute named \"#{@attribute_name}\""
    end
  end

end