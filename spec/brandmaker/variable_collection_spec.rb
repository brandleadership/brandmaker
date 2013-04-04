require 'spec_helper'

describe Brandmaker::VariableCollection do

  let :collection do
    Brandmaker::VariableCollection.new([
        { :technical_name => 'one' },
        { :technical_name => 'two', :purpose => VariablePurpose::EMAIL_RECIPIENT },
        { :technical_name => 'three' }
      ])
  end

  describe '#initialize' do
    it 'collects JobVariables' do
      collection.count.should be(3)
    end
  end

  describe '#find_by_technical_name' do
    context 'when the variable exists in the collection' do
      it 'returns the variable' do
        collection.find_by_technical_name('two').should be_a(Brandmaker::Variable)
      end
    end

    context 'when the variable does not exist in the collection' do
      it 'returns nil' do
        collection.find_by_technical_name('five').should be_nil
      end
    end
  end

  describe '#find_by_purpose' do
    context 'when the variable exists in the collection' do
      it 'returns the variable' do
        collection.find_by_purpose(VariablePurpose::EMAIL_RECIPIENT).should be_a(Brandmaker::Variable)
      end
    end

    context 'when the variable does not exist in the collection' do
      it 'raises an exception' do
        expect { collection.find_by_purpose(VariablePurpose::EMAIL_MESSAGE) }.to raise_error "#{VariablePurpose::EMAIL_MESSAGE} is not configured for this job"
      end
    end
  end

  describe '#unporposed' do
    it 'returns all variables without purpose' do
      collection.unpurposed.length.should be(2)
    end

    it 'returns a VariableCollection' do
      collection.unpurposed.should be_a(Brandmaker::VariableCollection)
    end
  end
end
