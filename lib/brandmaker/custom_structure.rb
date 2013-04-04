require 'brandmaker/configuration'

require 'savon'

module Brandmaker
  class CustomStructure
    extend Savon::Model

    client wsdl: Brandmaker.configuration.dse_service
    #client endpoint: Brandmaker.configuration.dse_service
    global :basic_auth, Brandmaker.configuration.user, Brandmaker.configuration.password

    #document Brandmaker.configuration.dse_service
    #endpoint Brandmaker.configuration.dse_service
    #basic_auth Brandmaker.configuration.user, Brandmaker.configuration.password

    operations :find_all_custom_structures

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
