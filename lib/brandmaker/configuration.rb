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
    attr_accessor :external_media_service
    attr_accessor :job_configs

    def initialize
      @user = 'screenconcept'
      @password = 'sc1234'
      @dse_service = 'https://brandmaker.kuoni.ch/webservices/dse/?wsdl'
      @media_pool_service = 'https://brandmaker.kuoni.ch/webservices/MediaPool/?wsdl'
      @external_media_service = 'https://brandmaker.kuoni.ch/GetMediaForExternalApplication.do'

      screenconcept = JobConfig.new('screenconcept__hauptjob').tap do |c|
        c.add_variables(
          :einfaches_textfeld,
          :einfachauswahl,
          { :name => :mehrzeiliges_textfeld_ohne_formatierung, :label => 'Langer Text' },
          :datumsauswahl,
          :mehrfachauswahl_selectionbox,
          :mehrfachauswahl_checkbox,
          { :name => :medienobjektauswahl, :content_type => :media },
          :datumsfeld_mit_zeitangabe,
          { :name => :email, :purpose => VariablePurpose::EMAIL_RECIPIENT },
          { :name => :betreff, :purpose => VariablePurpose::EMAIL_SUBJECT },
          { :name => :message, :purpose => VariablePurpose::EMAIL_MESSAGE }
        )
      end

      @job_configs = { :screenconcept__hauptjob => screenconcept }
    end
  end

end
