require 'brandmaker/variable'
require 'brandmaker/media_variable'
require 'brandmaker/grid_variable'

module Brandmaker
  class VariableConfig
    attr_accessor :name

    attr_accessor :label
    attr_accessor :content_type
    attr_accessor :purpose

    VARIABLE_TYPES = {
      :""             => Variable,
      :media          => MediaVariable,
      :external_media => ExternalMediaVariable,
      :grid           => GridVariable
    }

    def initialize(*h)
      if h.length == 1 && h.first.kind_of?(Hash)
        h.first.each { |k,v| send("#{k}=",v) }
      end
    end

    def to_typed_instance(data)
      type = content_type
      klass = VARIABLE_TYPES[content_type.to_s.downcase.to_sym]
      unless klass.nil?
        instance = klass.new(data)
        instance.config = self
        instance
      else
        raise "Unknown variable type #{type}"
      end
    end
  end

end
