require 'brandmaker/configuration'

require 'savon'

module Brandmaker
  class Job
    extend Savon::Model

    client wsdl: Brandmaker.configuration.dse_service
    #client endpoint: Brandmaker.configuration.dse_service
    global :basic_auth, Brandmaker.configuration.user, Brandmaker.configuration.password

    #document Brandmaker.configuration.dse_service
    #endpoint Brandmaker.configuration.dse_service
    #basic_auth Brandmaker.configuration.user, Brandmaker.configuration.password

    operations :find_by_id

    # ”desriptions" is a brandmaker typo in API

    def self.find id
      response = Job.new find_by_id(message: {:id => id})
      response.body[:find_by_id_response][:return]
    end

    def initialize data
      @data = data
      @plain_variables ||= Brandmaker::VariableCollection.new @data[:desriptions][:variable]
    end

    def id
      @data[:desriptions][:id]
    end

    def technical_name
      @data[:desriptions][:type_name]
    end

    def config
      Brandmaker.configuration.job_configs[self.technical_name.to_sym] or raise "Job #{self.id} is not configured, no config for #{self.technical_name}"
    end

    def variables
      available_variable_names = @plain_variables.map(&:technical_name)
      @variables ||= Brandmaker::VariableCollection.new(
        config.variables.select do |variable_config|
          available_variable_names.include? variable_config.name
        end.collect do |variable_config|
          variable = @plain_variables.find_by_technical_name(variable_config.name)
          configured_variable = variable_config.to_typed_instance(variable.data)
          configured_variable.config = variable_config
          configured_variable
        end, false)
    end

    def recipients
      val = variables.find_by_purpose(VariablePurpose::EMAIL_RECIPIENT).value
      val = [val] unless val.is_a? Array
      val
    end
  end
end
