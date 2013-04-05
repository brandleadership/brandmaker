module Brandmaker

  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield(configuration)

    configuration.dse_client = Savon.client do |wsdl, http, wsse|
      wsdl.document = configuration.dse_service
      wsdl.endpoint = configuration.dse_service
      http.auth.basic(configuration.user, configuration.password)
    end

    configuration.media_pool_client = Savon.client do |wsdl, http, wsse|
      wsdl.document = configuration.media_pool_service
      wsdl.endpoint = configuration.media_pool_service
      http.auth.basic(configuration.user, configuration.password)
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :user
    attr_accessor :password
    attr_accessor :dse_service
    attr_accessor :media_pool_service
    attr_accessor :external_media_service
    attr_accessor :job_configs

    attr_accessor :dse_client
    attr_accessor :media_pool_client

    def initialize
      @job_configs = {}
    end

    def media_pool_client
      @media_pool_client ||= Savon.client
    end

    def dse_client
      @dse_client ||= Savon.client
    end
  end

end
