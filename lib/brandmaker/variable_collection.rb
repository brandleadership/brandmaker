module Brandmaker
  class VariableCollection < Array

    def initialize variables, create = true
      if create
        super variables.map { |var| Brandmaker::Variable.new(var) }
      else
        super variables
      end
    end

    def find_by_technical_name(technical_name)
      self.find { |variable| variable.technical_name == technical_name }
    end

    def find_by_purpose(purpose)
      self.find { |variable| variable.purpose == purpose } || raise("#{purpose} is not configured for this job")
    end

    def unpurposed
      VariableCollection.new self.select { |var| var.purpose.blank? }, false
    end
  end
end
