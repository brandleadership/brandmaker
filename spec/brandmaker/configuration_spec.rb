require 'spec_helper'

module Brandmaker
  describe Configuration do

    describe 'default configuration' do
      it 'initializes a default configuration' do
        Brandmaker.configuration.should be_a(Configuration)
      end

      it 'initializes an empty job_configs hash' do
        Brandmaker.configuration.job_configs.should == {}
      end

      it 'initializes a default dse_client' do
        Brandmaker.configuration.dse_client.should be_a(Savon::Client)
      end

      it 'initializes a default media_pool_client' do
        Brandmaker.configuration.media_pool_client.should be_a(Savon::Client)
      end
    end

    describe '#configure' do
      context 'when calling configure' do
        before :each do
          Brandmaker.configure do |c|
            c.user = 'user'
            c.password = 'user'
            c.dse_service = 'dse_service_url'
            c.media_pool_service = 'media_pool_url'
          end
        end

        it 'creates a dse_client with the given configuration' do
          Brandmaker.configuration.dse_client.wsdl.document.should == 'dse_service_url'
          Brandmaker.configuration.dse_client.wsdl.endpoint.should == 'dse_service_url'
        end

        it 'creates a media_pool_client with the given configuration' do
          Brandmaker.configuration.media_pool_client.wsdl.document.should == 'media_pool_url'
          Brandmaker.configuration.media_pool_client.wsdl.endpoint.should == 'media_pool_url'
        end
      end
    end
  end
end
