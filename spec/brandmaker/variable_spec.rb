require 'spec_helper'

module Brandmaker
  describe Variable do

    describe '#purpose' do
      let :purpose do
        'purpose'
      end

      context 'when API provides purpose' do
        let :variable do
          Variable.new({ :purpose => purpose })
        end

        it 'returns purpose from API' do
          variable.purpose.should == purpose
        end
      end

      context 'when API provides no purpose' do
        let :variable do
          Variable.new({}).tap do |v|
            v.config = VariableConfig.new({ :purpose => purpose })
          end
        end

        it 'returns purpose from variable config' do
          variable.purpose.should be(purpose)
        end
      end

      context 'when neither API nor config provides purpose' do
        let :variable do
          Variable.new({})
        end

        it 'returns nil' do
          variable.purpose.should be_nil
        end
      end
    end

  end
end

