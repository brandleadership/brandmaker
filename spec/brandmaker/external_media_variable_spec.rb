require 'spec_helper'
require 'json'

module Brandmaker
  describe ExternalMediaVariable do

    describe '#value' do
      context 'when no value is available' do
        it 'returns nil' do
          var = ExternalMediaVariable.new({ :value => nil })
          var.value.should be_nil
        end
      end

      context 'when a single value is available' do
        it 'returns that value' do
          var = ExternalMediaVariable.new({ :value => "one" })
          var.value.should == 'one'
        end
      end

      context 'when multiple values are available' do
        it 'returns the last value' do
          var = ExternalMediaVariable.new({ :value => "one,two" })
          var.value.should == 'two'
        end
      end
    end

    describe '#reload' do
      before :each do
        Brandmaker.configuration.external_media_service = 'URL'
        Brandmaker.configuration.external_media_service_secret = 'SECRET'
      end

      let :var do
        ExternalMediaVariable.new({ :value => "130" })
      end

      context 'with valid mediaID' do
        before :each do
          RestClient.should_receive(:get).with(
            'URL', {:params => {:mediaID => "130", :secret => 'SECRET'}}
          ).and_return({
            :downloadUrl => "download url",
            :fileOriginalName => "original name"
          }.to_json)
        end

        it 'fetches media variable attributes from the API' do
          var.reload
          var.fileOriginalName.should == 'original name'
          var.downloadUrl.should == 'download url'
        end

        it 'returns self' do
          var.reload.should be(var)
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
