module Brandmaker
  class Variable
    attr_accessor :config

    def initialize data, config = VariableConfig.new
      @data = data
      @config = config
    end

    def data
      @data
    end

    def technical_name
      @data[:technical_name]
    end

    def value
      @data[:value]
    end

    def purpose
      # purpose is actually not provided by the api
      @data[:purpose] || config.purpose
    end

    def label
      config.label.presence || technical_name.humanize
    end

    def type_id
      @data[:variable_type_id]
    end
  end
end
