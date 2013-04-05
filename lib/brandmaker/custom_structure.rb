require 'brandmaker/configuration'

require 'savon'

module Brandmaker
  class CustomStructure
    extend Savon::Model

    actions :find_all_custom_structures

    def self.client
      Brandmaker.configuration.dse_client
    end

    class << self
      def find_by_technical_name technical_name
        name = custom_structure_name_for_mapped_technical_name(technical_name)
        unless name.nil?
          all.find { |cs| cs.name == name }
        else
          nil
        end
      end

      def all
        find_all_custom_structures.body[:find_all_custom_structures_response][:return][:custom_structures].collect do |data|
          CustomStructure.new data
        end
      end

      def custom_structure_name_for_mapped_technical_name technical_name
        {
          'anbieter_hinzufgen' => 'PM_ExterneSuppliers_Druckereien'
        }[technical_name]
      end
    end

    def initialize data
      @data = data
    end

    def name
      @data[:name]
    end

    def label
      @data[:name]
    end

    def objects
      @data[:objects]
    end
  end
end
