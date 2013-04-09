require 'rest_client'
require 'json'

module Brandmaker
  class ExternalMediaVariable < Variable
    attr_accessor :downloadUrl
    attr_accessor :fileOriginalName

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
      self.fileOriginalName = hash['fileOriginalName']
      self.downloadUrl = hash['downloadUrl']
    end
  end
end
