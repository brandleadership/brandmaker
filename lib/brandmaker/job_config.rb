module Brandmaker
  class JobConfig
    attr_accessor :technical_name
    attr_accessor :variables

    def initialize technical_name, variables = []
      @technical_name = technical_name
      @variables = variables
    end

    def add_variables *vars
      vars.each_with_index do |var, index|
        hash = var.is_a?(Hash) ? var : { :name => var }
        variables << VariableConfig.new(hash)
      end
    end
  end
end
