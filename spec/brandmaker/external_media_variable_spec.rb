require 'spec_helper'
require 'json'

module Brandmaker
  describe ExternalMediaVariable do

    describe '#reload' do
      before :each do
        Brandmaker.configuration.external_media_service = 'URL'
        Brandmaker.configuration.external_media_service_secret = 'SECRET'
      end

      let :var do
        ExternalMediaVariable.new({
          :value => 130
        })
      end

      context 'with valid mediaID' do
        it 'fetches media variable attributes from the API' do
          RestClient.should_receive(:get).with(
            'URL', {:params => {:mediaID => 130, :secret => 'SECRET'}}
          ).and_return({
            :downloadUrl => "download url",
            :fileOriginalName => "original name"
          }.to_json)

          var.reload
          var.fileOriginalName.should == 'original name'
          var.downloadUrl.should == 'download url'
        end
      end

      context 'with invalid mediaID' do
        it 'fetches media variable attributes from the API' do
          RestClient.should_receive(:get).and_return({
            :ERROR => "Requested media not found!"
          }.to_json)
          expect { var.reload }.to raise_error(/Requested media not found/)
        end
      end
    end

  end
end
