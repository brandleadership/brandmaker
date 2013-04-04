module Brandmaker

  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield(self.configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :user
    attr_accessor :password
    attr_accessor :dse_service
    attr_accessor :media_pool_service
    attr_accessor :job_configs

    def initialize
      @dse_service = 'https://brandmaker.kuoni.ch/webservices/dse/?wsdl'
      @media_pool_service = 'https://brandmaker.kuoni.ch/webservices/MediaPool/?wsdl'
      @external_media_service = 'https://brandmaker.kuoni.ch/GetMediaForExternalApplication.do'
      @job_configs = {}
    end
  end

end
