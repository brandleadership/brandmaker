require 'spec_helper'

describe Brandmaker::CustomStructure do

  describe 'class methods' do
    before do
      Brandmaker::CustomStructure.stub!(:find_all_custom_structures)
      .and_return(mock(Object, :body => custom_structure_all_data))
    end

    describe '.all' do
      it 'returns an array of Brandmaker::CustomStructure instances' do
        Brandmaker::CustomStructure.all.should be_all { |cs| cs.should be_a(Brandmaker::CustomStructure) }
      end
    end

    describe '.find_by_technical_name' do
      context 'when the technical name successfully matches a mapping' do
        it 'returns an instance of Brandmaker::CustomStructure' do
          Brandmaker::CustomStructure.find_by_technical_name('anbieter_hinzufgen').should be_a(Brandmaker::CustomStructure)
        end

        it 'accesses the custom structure collection' do
          Brandmaker::CustomStructure.should_receive(:all).and_return []
          Brandmaker::CustomStructure.find_by_technical_name('anbieter_hinzufgen')
        end
      end

      context 'when the technical name does not match a mapping' do
        it 'returns nil' do
          Brandmaker::CustomStructure.find_by_technical_name('anything').should be_nil
        end

        it 'does not access the collection' do
          Brandmaker::CustomStructure.should_not_receive(:all)
          Brandmaker::CustomStructure.find_by_technical_name('anything')
        end
      end
    end

    describe '.custom_structure_name_for_mapped_technical_name' do
      it 'maps a technical name of variable to a custom structure name' do
        mapped_value = 'PM_ExterneSuppliers_Druckereien'
        Brandmaker::CustomStructure.custom_structure_name_for_mapped_technical_name('anbieter_hinzufgen').should == mapped_value
      end
    end
  end

  describe 'instance methods' do
    let :custom_structure do
      Brandmaker::CustomStructure.new custom_structure_external_suppliers_data
    end

    describe '#name' do
      it 'returns the name' do
        custom_structure.name.should == 'PM_ExterneSuppliers_Druckereien'
      end
    end

    describe '#label' do
      it 'returns the label' do
        custom_structure.label.should == 'PM_ExterneSuppliers_Druckereien'
      end
    end

    describe '#objects' do
      it 'returns an array of hashes' do
        custom_structure.objects.should be_all { |h| h.should be_a(Hash) }
      end
    end
  end
end

