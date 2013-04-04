require 'active_support/core_ext'

require 'brandmaker/variable'

module Brandmaker
  class GridVariable < Variable
    def value
      begin
        if custom_structure.present?
          values = custom_structure_values
        else
          values = actual_values
        end

        if purpose == VariablePurpose::EMAIL_RECIPIENT
          values.map { |val| extract_email val }.compact
        else
          values
        end
      rescue
        super
      end
    end

    def actual_values
      rows.map do |row|
        row.try(:[], :variable).try(:[], :value).presence
      end.compact
    end

    def custom_structure_values
      actual_values.collect do |val|
        obj = custom_structure.objects.find do |object|
          object[:name] == val
        end
        obj[:label]
      end
    end

    def rows
      values = @data[:grid][:row]
      values = [values] if values.is_a? Hash
      values
    end

    def extract_email val
      val.match(/\(([^)]+)\)/).try(:[], 1)
    end

    def custom_structure
      @custom_structure ||= Brandmaker::CustomStructure.find_by_technical_name(self.technical_name)
      @custom_structure
    end
  end
end
