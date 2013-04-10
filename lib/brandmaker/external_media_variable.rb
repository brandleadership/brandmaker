require 'rest_client'
require 'json'

module Brandmaker
  class ExternalMediaVariable < Variable
    attr_accessor :downloadUrl
    attr_accessor :fileOriginalName
    attr_accessor :fileType

    def reload
      res = RestClient.get(
        Brandmaker.configuration.external_media_service,
        {
          :params => {
            :mediaID => value,
            :secret => Brandmaker.configuration.external_media_service_secret
          }
        }
      )
      hash = JSON.parse(res)
      error = hash['ERROR'].presence
      if error
        raise error
      end
      self.fileOriginalName = hash['fileOriginalName']
      self.downloadUrl = hash['downloadUrl']
      self.fileType = hash['fileType']
      self
    end
  end
end
