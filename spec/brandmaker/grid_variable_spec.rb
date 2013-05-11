require 'spec_helper'

module Brandmaker
  describe GridVariable do
    describe '#value' do

      context 'without a matching custom structure' do
        context 'when the purpose is not present' do
          let :grid_var do
            g = Brandmaker::GridVariable.new grid_variable_data
            g.stub!(:custom_structure).and_return(nil)
            g
          end

          it 'returns an array of values' do
            grid_var.value.should == grid_var.actual_values
          end

          it 'returns the actual values' do
            grid_var.should_receive(:actual_values).once
            grid_var.should_not_receive(:custom_structure_values)
            grid_var.value
          end
        end

        context 'when the purpose is the email recipient' do
          let :grid_var do
            g = Brandmaker::GridVariable.new grid_variable_email_data
            g.stub!(:custom_structure).and_return(nil)
            g.stub(:purpose).and_return(VariablePurpose::EMAIL_RECIPIENT)
            g
          end

          it 'returns an array of email addresses' do
            grid_var.value.should == %w(imanul@screenconcept.ch michif@gateb.com)
          end

          it 'parses the values' do
            grid_var.should_receive(:extract_email).twice
            grid_var.value
          end
        end
      end

      context 'with a matching custom structure' do
        it 'returns the custom structure values' do
          grid_var = Brandmaker::GridVariable.new grid_variable_data
          grid_var.stub(:custom_structure).and_return Brandmaker::CustomStructure.new({})
          grid_var.should_receive(:custom_structure_values).once.and_return %w(A B)
          grid_var.value.should == %w(A B)
        end
      end
    end

    describe '#actual_values' do
      let :grid_var do
        Brandmaker::GridVariable.new grid_variable_data
      end

      it 'does not fail' do
        grid_var.stub(:rows).and_return [{:worthless => nil}]
        expect { grid_var.actual_values }.to_not raise_error
      end

      it 'returns an array of values' do
        grid_var.value.should == %w(Immanuel Michi)
      end
    end

    describe '#custom_structure_values' do
      let :custom_structure do
        Brandmaker::CustomStructure.new :objects => [
          {:name => 'Immanuel', :label => 'Immanuel X'},
          {:name => 'Michi', :label => 'Michi X'}
        ]
      end

      let :grid_var do
        g = Brandmaker::GridVariable.new(grid_variable_data)
        g.stub(:custom_structure).and_return custom_structure
        g
      end

      it 'returns the mapped custom structure values' do
        grid_var.custom_structure_values.should == ['Immanuel X', 'Michi X']
      end
    end

    describe '#extract_email' do
      it 'parses the email address from the value' do
        grid_var = Brandmaker::GridVariable.new({})
        grid_var.stub!(:custom_structure).and_return(nil)
        address = grid_var.extract_email('Immanuel (imanul@screenconcept.ch)')
        address.should == 'imanul@screenconcept.ch'
      end
    end

    describe '#rows' do
      context 'when there is only a single row returned as hash from the API' do
        let :grid_var do
          Brandmaker::GridVariable.new grid_variable_single_row_data
        end

        it 'returns an array' do
          grid_var.rows.should be_a(Array)
        end

        it 'does not fail' do
          expect { grid_var.rows }.to_not raise_error
        end
      end

      context 'when there are multiple rows returns as array from the API' do
        let :grid_var do
          Brandmaker::GridVariable.new grid_variable_data
        end

        it 'returns an array' do
          grid_var.rows.should be_a(Array)
        end

        it 'does not fail' do
          expect { grid_var.rows }.to_not raise_error
        end
      end
    end

    describe '#custom_structure' do
      context 'when the technical name is mapped' do
        before do
          Brandmaker::CustomStructure.should_receive(:find_all_custom_structures)
          .and_return(mock(Object, :body => custom_structure_all_data))
        end

        it 'returns a custom structure' do
          grid_var = Brandmaker::GridVariable.new({:technical_name => 'anbieter_hinzufgen'})
          grid_var.custom_structure.should be_a(Brandmaker::CustomStructure)
        end
      end

      context 'when the technical name is not mapped' do
        before do
          Brandmaker::CustomStructure.should_not_receive(:find_all_custom_structures)
        end

        it 'returns nil' do
          grid_var = Brandmaker::GridVariable.new({:technical_name => 'anything'})
          grid_var.custom_structure.should be_nil
        end
      end
    end
  end
end
